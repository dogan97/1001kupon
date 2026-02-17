<!--#include file="../_config/veritabani.inc"--><!--#include file="../_config/json.inc"--><!--#include file="../_config/security.inc"-->
<%
Response.CodePage = 65001
Response.CharSet = "utf-8"
Response.ContentType = "application/json"

RequireLogin()
' CsrfValidate() ' Gecici olarak iptal

On Error Resume Next

Dim conn:Set conn=DbConn()
Dim cmd:Set cmd=Server.CreateObject("ADODB.Command")
Set cmd.ActiveConnection=conn: cmd.CommandType=4: cmd.CommandText="dbo.sp_kupon_oldur"
cmd.Parameters.Append cmd.CreateParameter("@firma_id",3,1,,CLng(Session("firma_id")))
cmd.Parameters.Append cmd.CreateParameter("@kullanici_id",3,1,,CLng(Session("kullanici_id")))
cmd.Parameters.Append cmd.CreateParameter("@kupon_kodu",200,1,60,UCase(Trim(Request.Form("kupon_kodu"))))
cmd.Parameters.Append cmd.CreateParameter("@siparis_no",200,1,50,Trim(Request.Form("siparis_no")))
cmd.Parameters.Append cmd.CreateParameter("@sepet_tutar",5,1,,Null)
Dim pOk:Set pOk=cmd.CreateParameter("@ok",3,2): cmd.Parameters.Append pOk
Dim pMsg:Set pMsg=cmd.CreateParameter("@mesaj",200,2,200): cmd.Parameters.Append pMsg

cmd.Execute

If Err.Number <> 0 Then
  JsonWriteErr "SQL Hatasi: " & Err.Description
  Response.End
End If

If CLng(pOk.Value)=1 Then
  JsonWriteOk "OK"
Else
  JsonWriteErr pMsg.Value
End If
%>
