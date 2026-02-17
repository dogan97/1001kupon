<!--#include file="../_config/veritabani.inc"--><!--#include file="../_config/json.inc"--><!--#include file="../_config/security.inc"-->
<% RequireLogin()
Dim conn:Set conn=DbConn()
Dim cmd:Set cmd=Server.CreateObject("ADODB.Command")
Set cmd.ActiveConnection=conn
cmd.CommandText="SELECT kontor,toplam,bekleyen,kullanilan,suresi_dolan FROM vw_firma_ozet WHERE firma_id=?"
cmd.Parameters.Append cmd.CreateParameter("@f",3,1,,CLng(Session("firma_id")))
Dim rs:Set rs=cmd.Execute
If rs.EOF Then JsonWrite "{""ok"":true,""data"":{""kontor"":0,""toplam"":0,""bekleyen"":0,""kullanilan"":0,""suresi_dolan"":0}}"
Else JsonWrite "{""ok"":true,""data"":{""kontor"":"&rs("kontor")&",""toplam"":"&rs("toplam")&",""bekleyen"":"&rs("bekleyen")&",""kullanilan"":"&rs("kullanilan")&",""suresi_dolan"":"&rs("suresi_dolan")&"}}"
End If
%>
