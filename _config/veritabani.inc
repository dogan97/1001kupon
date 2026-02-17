<%
' --- BAGLANTI AYARLARI ---
' Sunucu: 127.0.0.1 (Localhost IP)
' Port: 1433 (Standart SQL Portu)
' Kullanici: boserver
' Sifre: Bora123???

Const DB_CONN_STR = "Provider=SQLOLEDB;Data Source=SRVMNJR25\SQLEXPRESS;Initial Catalog=KUPON1001;User ID=boserver;Password=Bora123???;"

' --- SITE AYARLARI ---
' Alt klasorde calisiyorsa buraya klasor adini yazin (Orn: "/dogan-1001kupon")
' Ana dizinde calisiyorsa bos birakin ("")
Const ROOT_PATH = "/dogan-1001kupon"

Function DbConn()
  Dim c: Set c = Server.CreateObject("ADODB.Connection")
  c.Open DB_CONN_STR
  Set DbConn = c
End Function
%>
