<%
On Error Resume Next
Response.Write "<h1>Veritabani Baglanti Testi</h1>"
%>
<!--#include file="_config/veritabani.inc"-->
<%
If Err.Number <> 0 Then
    Response.Write "<p style='color:red'>Include Hatasi (Dosya bulunamadi veya hatali): " & Err.Description & "</p>"
    Response.End
End If

' Sifreyi gizleyerek gosterelim
Dim safeStr
safeStr = Replace(DB_CONN_STR, "PWD=", "PWD=***")
Response.Write "<p>Kullanilan Baglanti Cumlesi: <code>" & safeStr & "</code></p>"

Dim conn
Set conn = DbConn()

If Err.Number <> 0 Then
    Response.Write "<p style='color:red; font-weight:bold'>BAGLANTI HATASI: " & Err.Description & "</p>"
    Response.Write "<p>Lutfen _config/veritabani.inc dosyasindaki sifrenizi kontrol edin.</p>"
Else
    Response.Write "<p style='color:green; font-weight:bold; font-size:20px'>BAGLANTI BASARILI! ✅</p>"
    conn.Close
End If
%>
