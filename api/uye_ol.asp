<!--#include file="../_config/veritabani.inc"--><!--#include file="../_config/json.inc"--><!--#include file="../_config/security.inc"-->
<%
Response.CodePage = 65001
Response.CharSet = "utf-8"
Response.ContentType = "application/json"

On Error Resume Next

' CsrfValidate() ' Gecici olarak iptal

Dim conn, cmd
Set conn = DbConn()
If Err.Number <> 0 Then
    Response.Clear
    Response.Status = "200 OK"
    Response.Write "{""ok"":false,""message"":""Veritabani Baglanti Hatasi: " & Replace(Err.Description, """", "'") & """}"
    Response.End
End If

Set cmd = Server.CreateObject("ADODB.Command")
Set cmd.ActiveConnection = conn
cmd.CommandType = 4 'adCmdStoredProc
cmd.CommandText = "dbo.sp_firma_kayit"

' Parametreleri ekle
cmd.Parameters.Append cmd.CreateParameter("@firma_adi", 200, 1, 200, Trim(Request.Form("firma_adi")))
cmd.Parameters.Append cmd.CreateParameter("@sektor", 200, 1, 100, Trim(Request.Form("sektor")))
cmd.Parameters.Append cmd.CreateParameter("@vergi_no", 200, 1, 50, "")
cmd.Parameters.Append cmd.CreateParameter("@sehir", 200, 1, 100, "")
cmd.Parameters.Append cmd.CreateParameter("@website", 200, 1, 200, "")
cmd.Parameters.Append cmd.CreateParameter("@yetkili_ad", 200, 1, 150, Trim(Request.Form("yetkili_ad")))
cmd.Parameters.Append cmd.CreateParameter("@email", 200, 1, 200, LCase(Trim(Request.Form("email"))))
cmd.Parameters.Append cmd.CreateParameter("@telefon", 200, 1, 50, Trim(Request.Form("telefon")))
cmd.Parameters.Append cmd.CreateParameter("@sifre", 200, 1, 200, CStr(Request.Form("sifre")))

' Output parametreleri
Dim pU, pF
Set pU = cmd.CreateParameter("@kullanici_id", 3, 2) 'adInteger, adParamOutput
cmd.Parameters.Append pU
Set pF = cmd.CreateParameter("@firma_id", 3, 2) 'adInteger, adParamOutput
cmd.Parameters.Append pF

cmd.Execute

If Err.Number <> 0 Then
    Response.Clear
    Response.Status = "200 OK"
    Response.Write "{""ok"":false,""message"":""SQL Hatasi (" & Err.Number & "): " & Replace(Err.Description, """", "'") & """}"
    Response.End
End If

Session("kullanici_id") = pU.Value
Session("firma_id") = pF.Value

Response.Write "{""ok"":true}"
%>
