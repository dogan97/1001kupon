<!--#include file="../_config/veritabani.inc"-->
<!--#include file="../_config/json.inc"-->
<!--#include file="../_config/security.inc"-->


<%
' CsrfValidate() ' Gecici olarak iptal
On Error Resume Next

Dim conn:Set conn=DbConn()
Dim cmd:Set cmd=Server.CreateObject("ADODB.Command")
Set cmd.ActiveConnection=conn: cmd.CommandType=4: cmd.CommandText="dbo.sp_kullanici_giris"
cmd.Parameters.Append cmd.CreateParameter("@email",200,1,200,LCase(Trim(Request.Form("email"))))
cmd.Parameters.Append cmd.CreateParameter("@sifre",200,1,200,CStr(Request.Form("sifre")))
Dim pOk:Set pOk=cmd.CreateParameter("@ok",3,2): cmd.Parameters.Append pOk
Dim pMsg:Set pMsg=cmd.CreateParameter("@mesaj",200,2,200): cmd.Parameters.Append pMsg
Dim pU:Set pU=cmd.CreateParameter("@kullanici_id",3,2): cmd.Parameters.Append pU
Dim pF:Set pF=cmd.CreateParameter("@firma_id",3,2): cmd.Parameters.Append pF

cmd.Execute

If Err.Number <> 0 Then
  JsonWriteErr "Sunucu Hatasi: " & Err.Description
  Response.End
End If

If CLng(pOk.Value)=1 Then
  Session("kullanici_id")=pU.Value
  Session("firma_id")=pF.Value
  JsonWrite "{""ok"":true}"
Else
  JsonWriteErr pMsg.Value
End If
%>
