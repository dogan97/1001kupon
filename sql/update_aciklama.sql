
-- 1. Tabloya 'aciklama' kolonu ekle
IF NOT EXISTS(SELECT * FROM sys.columns WHERE Name = N'aciklama' AND Object_ID = Object_ID(N'dbo.kupon_tanimlari'))
BEGIN
    ALTER TABLE dbo.kupon_tanimlari ADD aciklama NVARCHAR(500) NULL;
END
GO

-- 2. Stored Procedure'ü guncelle (aciklama parametresi ile)
CREATE OR ALTER PROCEDURE dbo.sp_kupon_tanim_ekle
    @firma_id INT,
    @kullanici_id INT,
    @tanim_adi NVARCHAR(200),
    @aciklama NVARCHAR(500) = NULL, -- Yeni parametre
    @indirim_tipi INT,
    @indirim_degeri DECIMAL(18,2),
    @sepet_limit DECIMAL(18,2),
    @gecerlilik_gun INT,
    @tanim_id INT OUTPUT
AS
BEGIN
    INSERT INTO dbo.kupon_tanimlari(firma_id, kullanici_id, tanim_adi, aciklama, indirim_tipi, indirim_degeri, sepet_limit, gecerlilik_gun, tanim_kodu)
    VALUES(@firma_id, @kullanici_id, @tanim_adi, @aciklama, @indirim_tipi, @indirim_degeri, @sepet_limit, @gecerlilik_gun, 'DEF-' + CAST(NEWID() AS VARCHAR(8)));
    
    SET @tanim_id = SCOPE_IDENTITY();
    
    -- Okunabilir kod güncelle
    UPDATE dbo.kupon_tanimlari SET tanim_kodu = 'DEF-' + RIGHT('00000' + CAST(@tanim_id AS VARCHAR), 6) WHERE tanim_id=@tanim_id;
END
GO
