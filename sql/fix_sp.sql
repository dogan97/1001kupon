USE [KUPON1001];
GO

-- Bu script, "Insufficient result space" hatasını düzelten prosedür güncellemesidir.

ALTER PROCEDURE dbo.sp_kupon_tanim_ekle
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
    -- DÜZELTME: NEWID() doğrudan varchar(8)'e çevrilirken hata veriyordu.
    -- Önce varchar(36)'ya çevirip sonra ilk 8 karakterini alıyoruz.
    DECLARE @temp_kod VARCHAR(50);
    SET @temp_kod = 'DEF-' + LEFT(CAST(NEWID() AS VARCHAR(36)), 8);

    INSERT INTO dbo.kupon_tanimlari(firma_id, kullanici_id, tanim_adi, indirim_tipi, indirim_degeri, sepet_limit, gecerlilik_gun, tanim_kodu)
    VALUES(@firma_id, @kullanici_id, @tanim_adi, @indirim_tipi, @indirim_degeri, @sepet_limit, @gecerlilik_gun, @temp_kod);
    
    SET @tanim_id = SCOPE_IDENTITY();
    
    -- Sonrasında zaten ID'ye göre güncelliyoruz
    UPDATE dbo.kupon_tanimlari SET tanim_kodu = 'DEF-' + RIGHT('00000' + CAST(@tanim_id AS VARCHAR), 6) WHERE tanim_id=@tanim_id;
END
GO
