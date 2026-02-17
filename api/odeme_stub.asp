<!--#include file="../_config/veritabani.inc"--><!--#include file="../_config/json.inc"--><!--#include file="../_config/security.inc"-->
<% RequireLogin(): CsrfValidate()
Dim conn:Set conn=DbConn()
Dim cmd:Set cmd=Server.CreateObject("ADODB.Command")
Set cmd.ActiveConnection=conn: cmd.CommandType=4: cmd.CommandText="dbo.sp_odeme_stub"
cmd.Parameters.Append cmd.CreateParameter("@firma_id",3,1,,CLng(Session("firma_id")))
cmd.Parameters.Append cmd.CreateParameter("@kullanici_id",3,1,,CLng(Session("kullanici_id")))
cmd.Parameters.Append cmd.CreateParameter("@paket",3,1,,CLng(Request.Form("paket")))
cmd.Execute
JsonWriteOk "OK"
%>
