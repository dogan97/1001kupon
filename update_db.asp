<!--#include file="_config/veritabani.inc"-->
<%
Response.ContentType = "text/html"
On Error Resume Next

Dim conn, cmd
Set conn = DbConn()

If Err.Number <> 0 Then
    Response.Write "<h1>Veritabani Baglanti Hatasi</h1>"
    Response.Write "<p>" & Err.Description & "</p>"
    Response.End
End If

' SQL Komutlarini Calistir
' NOT: GO komutu T-SQL'de batch separator oldugu icin ADODB ile tek seferde calismaz.
' Bu yuzden parca parca calistiracagiz.

' 1. Adim: Kolon Ekleme
Dim sql1
sql1 = "IF NOT EXISTS(SELECT * FROM sys.columns WHERE Name = N'aciklama' AND Object_ID = Object_ID(N'dbo.kupon_tanimlari')) " & _
       "BEGIN ALTER TABLE dbo.kupon_tanimlari ADD aciklama NVARCHAR(500) NULL; END"

conn.Execute sql1
If Err.Number <> 0 Then
    Response.Write "<p style='color:red'>Hata (Kolon Ekleme): " & Err.Description & "</p>"
    Err.Clear
Else
    Response.Write "<p style='color:green'>Basarili: 'aciklama' kolonu eklendi veya zaten vardi.</p>"
End If

' 2. Adim: SP Guncelleme
Dim sql2
sql2 = "CREATE OR ALTER PROCEDURE dbo.sp_kupon_tanim_ekle " & _
       "@firma_id INT, @kullanici_id INT, @tanim_adi NVARCHAR(200), @aciklama NVARCHAR(500) = NULL, " & _
       "@indirim_tipi INT, @indirim_degeri DECIMAL(18,2), @sepet_limit DECIMAL(18,2), " & _
       "@gecerlilik_gun INT, @tanim_id INT OUTPUT AS " & _
       "BEGIN " & _
       "INSERT INTO dbo.kupon_tanimlari(firma_id, kullanici_id, tanim_adi, aciklama, indirim_tipi, indirim_degeri, sepet_limit, gecerlilik_gun, tanim_kodu) " & _
       "VALUES(@firma_id, @kullanici_id, @tanim_adi, @aciklama, @indirim_tipi, @indirim_degeri, @sepet_limit, @gecerlilik_gun, 'DEF-' + CAST(NEWID() AS VARCHAR(8))); " & _
       "SET @tanim_id = SCOPE_IDENTITY(); " & _
       "UPDATE dbo.kupon_tanimlari SET tanim_kodu = 'DEF-' + RIGHT('00000' + CAST(@tanim_id AS VARCHAR), 6) WHERE tanim_id=@tanim_id; " & _
       "END"

conn.Execute sql2
If Err.Number <> 0 Then
    Response.Write "<p style='color:red'>Hata (SP Guncelleme): " & Err.Description & "</p>"
Else
    Response.Write "<p style='color:green'>Basarili: 'sp_kupon_tanim_ekle' guncellendi.</p>"
End If

Response.Write "<hr><h3>Islem Tamamlandi. Bu dosyayi silebilirsiniz.</h3>"
Response.Write "<a href='" & ROOT_PATH & "/panel/index.asp'>Panele Don</a>"
%>
