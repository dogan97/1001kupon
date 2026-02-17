-- Veritabanı varsa kullan, yoksa hata vermez
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'KUPON1001')
BEGIN
    CREATE DATABASE [KUPON1001]
END
GO
USE [KUPON1001];
GO

SET NOCOUNT ON;
SET XACT_ABORT ON;
GO

/* ---------------------------------------------------------
   1. TABLOLAR (ASP Kodlarındaki isimlerle)
--------------------------------------------------------- */

-- Firmalar
IF OBJECT_ID('dbo.firmalar','U') IS NULL
BEGIN
  CREATE TABLE dbo.firmalar(
      firma_id      INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
      firma_adi     NVARCHAR(200) NOT NULL,
      sektor        NVARCHAR(100) NULL,
      vergi_no      NVARCHAR(50) NULL,
      sehir         NVARCHAR(100) NULL,
      website       NVARCHAR(200) NULL,
      telefon       NVARCHAR(50) NULL,
      
      bakiye        INT DEFAULT(0) NOT NULL, -- Kontör bakiyesi burada
      
      durum         TINYINT DEFAULT(1) NOT NULL, -- 1:Aktif
      kayit_tarihi  DATETIME DEFAULT(GETDATE())
  );
END
GO

-- Kullanıcılar
IF OBJECT_ID('dbo.kullanicilar','U') IS NULL
BEGIN
  CREATE TABLE dbo.kullanicilar(
      kullanici_id  INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
      firma_id      INT NOT NULL,
      ad_soyad      NVARCHAR(150) NOT NULL,
      email         NVARCHAR(200) NOT NULL,
      sifre         NVARCHAR(200) NOT NULL, -- Düz metin veya basit hash (Legacy ASP)
      
      rol           TINYINT DEFAULT(1), -- 1:Admin
      durum         TINYINT DEFAULT(1),
      kayit_tarihi  DATETIME DEFAULT(GETDATE()),
      
      FOREIGN KEY(firma_id) REFERENCES dbo.firmalar(firma_id)
  );
  CREATE UNIQUE INDEX UX_Email ON dbo.kullanicilar(email);
END
GO

-- Kupon Tanımları (Definitions)
IF OBJECT_ID('dbo.kupon_tanimlari','U') IS NULL
BEGIN
  CREATE TABLE dbo.kupon_tanimlari(
      tanim_id       INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
      firma_id       INT NOT NULL,
      kullanici_id   INT NULL,
      
      tanim_kodu     NVARCHAR(50) NULL, -- DEF-001
      tanim_adi      NVARCHAR(200) NOT NULL,
      indirim_tipi   INT NOT NULL, -- 1:Tutar, 2:Yüzde
      indirim_degeri DECIMAL(18,2) NOT NULL,
      sepet_limit    DECIMAL(18,2) DEFAULT(0),
      gecerlilik_gun INT DEFAULT(30),
      
      durum          TINYINT DEFAULT(1), -- 1:Aktif
      silindi        BIT DEFAULT(0),
      kayit_tarihi   DATETIME DEFAULT(GETDATE()),
      
      FOREIGN KEY(firma_id) REFERENCES dbo.firmalar(firma_id)
  );
END
GO

-- Kuponlar (Asıl kodlar)
IF OBJECT_ID('dbo.kuponlar','U') IS NULL
BEGIN
  CREATE TABLE dbo.kuponlar(
      kupon_id        BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
      firma_id        INT NOT NULL,
      tanim_id        INT NOT NULL,
      batch_id        BIGINT NULL, -- Hangi partide üretildi
      
      kupon_kodu      NVARCHAR(50) NOT NULL,
      durum           TINYINT DEFAULT(1), -- 1:Bekliyor, 2:Kullanıldı
      
      uretildi_tarih  DATETIME DEFAULT(GETDATE()),
      bitis_tarihi    DATETIME NOT NULL,
      
      kullanma_tarihi DATETIME NULL,
      siparis_no      NVARCHAR(50) NULL,
      
      FOREIGN KEY(firma_id) REFERENCES dbo.firmalar(firma_id),
      FOREIGN KEY(tanim_id) REFERENCES dbo.kupon_tanimlari(tanim_id)
  );
  CREATE UNIQUE INDEX UX_KuponKodu ON dbo.kuponlar(kupon_kodu);
  CREATE INDEX IX_FirmaDurum ON dbo.kuponlar(firma_id, durum);
END
GO

-- İşlem Logları (Ledger/Audit)
IF OBJECT_ID('dbo.islem_loglari','U') IS NULL
BEGIN
  CREATE TABLE dbo.islem_loglari(
      log_id        BIGINT IDENTITY(1,1) NOT NULL PRIMARY KEY,
      firma_id      INT NOT NULL,
      kullanici_id  INT NULL,
      islem_tipi    NVARCHAR(50), -- URETİM, ODEME, KULLANIM
      aciklama      NVARCHAR(500),
      tarih         DATETIME DEFAULT(GETDATE())
  );
END
GO

/* ---------------------------------------------------------
   2. VIEW'LER (Raporlama İçin)
--------------------------------------------------------- */

-- Özet Rapor View
CREATE OR ALTER VIEW dbo.vw_firma_ozet
AS
SELECT 
    f.firma_id,
    f.bakiye AS kontor,
    (SELECT COUNT(*) FROM dbo.kuponlar WHERE firma_id = f.firma_id) AS toplam,
    (SELECT COUNT(*) FROM dbo.kuponlar WHERE firma_id = f.firma_id AND durum=1 AND bitis_tarihi > GETDATE()) AS bekleyen,
    (SELECT COUNT(*) FROM dbo.kuponlar WHERE firma_id = f.firma_id AND durum=2) AS kullanilan,
    (SELECT COUNT(*) FROM dbo.kuponlar WHERE firma_id = f.firma_id AND durum=1 AND bitis_tarihi < GETDATE()) AS suresi_dolan
FROM dbo.firmalar f;
GO

-- Günlük Kullanım Grafiği View
CREATE OR ALTER VIEW dbo.vw_firma_gunluk_kullanim
AS
SELECT 
    firma_id,
    CONVERT(VARCHAR(10), kullanma_tarihi, 120) AS [gun],
    COUNT(*) AS kullanim
FROM dbo.kuponlar
WHERE durum=2 AND kullanma_tarihi IS NOT NULL
GROUP BY firma_id, CONVERT(VARCHAR(10), kullanma_tarihi, 120);
GO

/* ---------------------------------------------------------
   3. STORED PROCEDURES (ASP'nin Çağırdığı İsimlerle)
--------------------------------------------------------- */

-- 1. Firma Kayıt
CREATE OR ALTER PROCEDURE dbo.sp_firma_kayit
    @firma_adi NVARCHAR(200),
    @sektor NVARCHAR(100),
    @vergi_no NVARCHAR(50),
    @sehir NVARCHAR(100),
    @website NVARCHAR(200),
    @yetkili_ad NVARCHAR(150),
    @email NVARCHAR(200),
    @telefon NVARCHAR(50),
    @sifre NVARCHAR(200),
    @kullanici_id INT OUTPUT,
    @firma_id INT OUTPUT
AS
BEGIN
    IF EXISTS(SELECT 1 FROM dbo.kullanicilar WHERE email=@email)
    BEGIN
        RAISERROR('Bu email adresi zaten kayıtlı.', 16, 1);
        RETURN;
    END

    BEGIN TRAN
    
    INSERT INTO dbo.firmalar(firma_adi, sektor, vergi_no, sehir, website, telefon, bakiye)
    VALUES(@firma_adi, @sektor, @vergi_no, @sehir, @website, @telefon, 100); -- Hediye 100 kontör
    
    SET @firma_id = SCOPE_IDENTITY();
    
    INSERT INTO dbo.kullanicilar(firma_id, ad_soyad, email, sifre, rol)
    VALUES(@firma_id, @yetkili_ad, @email, @sifre, 1);
    
    SET @kullanici_id = SCOPE_IDENTITY();
    
    COMMIT
END
GO

-- 2. Kullanıcı Giriş
CREATE OR ALTER PROCEDURE dbo.sp_kullanici_giris
    @email NVARCHAR(200),
    @sifre NVARCHAR(200),
    @ok INT OUTPUT,
    @mesaj NVARCHAR(200) OUTPUT,
    @kullanici_id INT OUTPUT,
    @firma_id INT OUTPUT
AS
BEGIN
    SELECT @kullanici_id = kullanici_id, @firma_id = firma_id
    FROM dbo.kullanicilar 
    WHERE email = @email AND sifre = @sifre AND durum = 1;

    IF @kullanici_id IS NOT NULL
    BEGIN
        SET @ok = 1;
        SET @mesaj = 'Giriş başarılı';
    END
    ELSE
    BEGIN
        SET @ok = 0;
        SET @mesaj = 'Email veya şifre hatalı.';
    END
END
GO

-- 3. Kupon Tanım Ekle
CREATE OR ALTER PROCEDURE dbo.sp_kupon_tanim_ekle
    @firma_id INT,
    @kullanici_id INT,
    @tanim_adi NVARCHAR(200),
    @indirim_tipi INT,
    @indirim_degeri DECIMAL(18,2),
    @sepet_limit DECIMAL(18,2),
    @gecerlilik_gun INT,
    @tanim_id INT OUTPUT
AS
BEGIN
    INSERT INTO dbo.kupon_tanimlari(firma_id, kullanici_id, tanim_adi, indirim_tipi, indirim_degeri, sepet_limit, gecerlilik_gun, tanim_kodu)
    VALUES(@firma_id, @kullanici_id, @tanim_adi, @indirim_tipi, @indirim_degeri, @sepet_limit, @gecerlilik_gun, 'DEF-' + CAST(NEWID() AS VARCHAR(8)));
    
    SET @tanim_id = SCOPE_IDENTITY();
    
    -- Okunabilir kod güncelle
    UPDATE dbo.kupon_tanimlari SET tanim_kodu = 'DEF-' + RIGHT('00000' + CAST(@tanim_id AS VARCHAR), 6) WHERE tanim_id=@tanim_id;
END
GO

-- 4. Kupon Üret (En Kritik Prosedür)
CREATE OR ALTER PROCEDURE dbo.sp_kupon_uret
    @firma_id INT,
    @kullanici_id INT,
    @tanim_id INT,
    @adet INT,
    @batch_id BIGINT OUTPUT,
    @maliyet INT OUTPUT,
    @mesaj NVARCHAR(200) OUTPUT
AS
BEGIN
    SET @maliyet = @adet; -- 1 Kupon = 1 Kontör
    SET @mesaj = '';

    -- Bakiye Kontrol
    DECLARE @mevcut_bakiye INT;
    SELECT @mevcut_bakiye = bakiye FROM dbo.firmalar WHERE firma_id = @firma_id;

    IF @mevcut_bakiye < @maliyet
    BEGIN
        SET @mesaj = 'Yetersiz bakiye. Lütfen kontör yükleyin.';
        RETURN;
    END

    -- Tanım Bilgisi Al
    DECLARE @gun INT;
    SELECT @gun = gecerlilik_gun FROM dbo.kupon_tanimlari WHERE tanim_id = @tanim_id;

    BEGIN TRAN

    -- Bakiye Düş
    UPDATE dbo.firmalar SET bakiye = bakiye - @maliyet WHERE firma_id = @firma_id;

    -- Batch ID üret (simülasyon)
    SET @batch_id = CAST(RAND() * 1000000 AS BIGINT); 

    -- Kuponları Döngüyle Üret (SQL Server 2017+ STRING_AGG veya Random için basit while)
    DECLARE @i INT = 0;
    WHILE @i < @adet
    BEGIN
        INSERT INTO dbo.kuponlar(firma_id, tanim_id, batch_id, kupon_kodu, bitis_tarihi)
        VALUES(@firma_id, @tanim_id, @batch_id, 
               'KPN-' + SUBSTRING(CONVERT(varchar(40), NEWID()), 1, 4) + '-' + SUBSTRING(CONVERT(varchar(40), NEWID()), 5, 4),
               DATEADD(DAY, @gun, GETDATE())
        );
        SET @i = @i + 1;
    END

    COMMIT
END
GO

-- 5. Kupon Öldür (Redeem)
CREATE OR ALTER PROCEDURE dbo.sp_kupon_oldur
    @firma_id INT,
    @kullanici_id INT,
    @kupon_kodu NVARCHAR(50),
    @siparis_no NVARCHAR(50),
    @sepet_tutar DECIMAL(18,2) = NULL,
    @ok INT OUTPUT,
    @mesaj NVARCHAR(200) OUTPUT
AS
BEGIN
    DECLARE @kid BIGINT;
    DECLARE @durum TINYINT;
    
    SELECT @kid = kupon_id, @durum = durum 
    FROM dbo.kuponlar WHERE kupon_kodu = @kupon_kodu AND firma_id = @firma_id;

    IF @kid IS NULL
    BEGIN
        SET @ok = 0; SET @mesaj = 'Kupon bulunamadı.'; RETURN;
    END

    IF @durum = 2
    BEGIN
        SET @ok = 0; SET @mesaj = 'Bu kupon zaten kullanılmış.'; RETURN;
    END

    UPDATE dbo.kuponlar 
    SET durum = 2, kullanma_tarihi = GETDATE(), siparis_no = @siparis_no
    WHERE kupon_id = @kid;

    SET @ok = 1;
    SET @mesaj = 'Kupon başarıyla kullanıldı.';
END
GO

-- 6. Ödeme Stub (Demo Kontör Yükleme)
CREATE OR ALTER PROCEDURE dbo.sp_odeme_stub
    @firma_id INT,
    @kullanici_id INT,
    @paket INT
AS
BEGIN
    UPDATE dbo.firmalar SET bakiye = bakiye + @paket WHERE firma_id = @firma_id;
    
    INSERT INTO dbo.islem_loglari(firma_id, kullanici_id, islem_tipi, aciklama)
    VALUES(@firma_id, @kullanici_id, 'ODEME', CAST(@paket AS VARCHAR) + ' kontör yüklendi.');
END
GO

PRINT '✅ 1001Kupon Türkçe Veritabanı (ASP Uyumlu) Başarıyla Kuruldu!';