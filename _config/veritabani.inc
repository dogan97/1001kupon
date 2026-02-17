<%
' --- BAGLANTI AYARLARI (LOCALHOST) ---
' Kullanici: sa
' Sifre: 123456aA

Const DB_CONN_STR = "Provider=MSOLEDBSQL;Server=.;Database=KUPON1001;UID=sa;PWD=123456aA;TrustServerCertificate=Yes;"

' --- SITE AYARLARI ---
' Localhost (Kok Dizin) icin bos birakin:
Const ROOT_PATH = "" 

Function DbConn()
  Dim c: Set c = Server.CreateObject("ADODB.Connection")
  c.Open DB_CONN_STR
  Set DbConn = c
End Function
%>
