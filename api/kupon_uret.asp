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
Set cmd.ActiveConnection=conn: cmd.CommandType=4: cmd.CommandText="dbo.sp_kupon_uret"
cmd.Parameters.Append cmd.CreateParameter("@firma_id",3,1,,CLng(Session("firma_id")))
cmd.Parameters.Append cmd.CreateParameter("@kullanici_id",3,1,,CLng(Session("kullanici_id")))
cmd.Parameters.Append cmd.CreateParameter("@tanim_id",3,1,,CLng(Request.Form("tanim_id")))
cmd.Parameters.Append cmd.CreateParameter("@adet",3,1,,CLng(Request.Form("adet")))
Dim pB:Set pB=cmd.CreateParameter("@batch_id",20,2): cmd.Parameters.Append pB
Dim pM:Set pM=cmd.CreateParameter("@maliyet",3,2): cmd.Parameters.Append pM
Dim pMsg:Set pMsg=cmd.CreateParameter("@mesaj",200,2,200): cmd.Parameters.Append pMsg

cmd.Execute

If Err.Number <> 0 Then
  JsonWriteErr "Veritabani hatasi: " & Err.Description
  Response.End
End If

If Len(pMsg.Value & "") > 0 Then
  JsonWriteErr pMsg.Value
Else
  JsonWrite "{""ok"":true,""batch_id"":" & pB.Value & ",""maliyet"":" & pM.Value & "}"
End If
%>
