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
Set cmd.ActiveConnection=conn: cmd.CommandType=4: cmd.CommandText="dbo.sp_kupon_tanim_ekle"
cmd.Parameters.Append cmd.CreateParameter("@firma_id",3,1,,CLng(Session("firma_id")))
cmd.Parameters.Append cmd.CreateParameter("@kullanici_id",3,1,,CLng(Session("kullanici_id")))
cmd.Parameters.Append cmd.CreateParameter("@tanim_adi",200,1,200,Trim(Request.Form("tanim_adi")))
cmd.Parameters.Append cmd.CreateParameter("@aciklama",200,1,500,Trim(Request.Form("aciklama")))
cmd.Parameters.Append cmd.CreateParameter("@indirim_tipi",3,1,,CLng(Request.Form("indirim_tipi")))
cmd.Parameters.Append cmd.CreateParameter("@indirim_degeri",5,1,,CDbl(Request.Form("indirim_degeri")))
cmd.Parameters.Append cmd.CreateParameter("@sepet_limit",5,1,,CDbl(Request.Form("sepet_limit")))
cmd.Parameters.Append cmd.CreateParameter("@gecerlilik_gun",3,1,,CLng(Request.Form("gecerlilik_gun")))
Dim pT:Set pT=cmd.CreateParameter("@tanim_id",3,2): cmd.Parameters.Append pT

cmd.Execute

If Err.Number <> 0 Then
  JsonWriteErr "SQL Hatasi: " & Err.Description
  Response.End
End If

JsonWrite "{""ok"":true,""tanim_id"":"&CLng(pT.Value)&"}"
%>
