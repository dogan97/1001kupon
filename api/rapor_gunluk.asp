<!--#include file="../_config/veritabani.inc"--><!--#include file="../_config/json.inc"--><!--#include file="../_config/security.inc"-->
<% RequireLogin()
Dim gun: gun=CLng(Request.QueryString("gun")): If gun<=0 Then gun=7
Dim conn:Set conn=DbConn()
Dim cmd:Set cmd=Server.CreateObject("ADODB.Command")
Set cmd.ActiveConnection=conn
cmd.CommandText="SELECT TOP " & gun & " gun,kullanim FROM vw_firma_gunluk_kullanim WHERE firma_id=? ORDER BY gun DESC"
cmd.Parameters.Append cmd.CreateParameter("@f",3,1,,CLng(Session("firma_id")))
Dim rs:Set rs=cmd.Execute
Dim a:a="[" : Dim first:first=True
Do Until rs.EOF
 If Not first Then a=a&"," Else first=False
 a=a&"{""gun"":"""&rs("gun")&""",""kullanim"":"&rs("kullanim")&"}"
 rs.MoveNext
Loop
a=a&"]"
JsonWrite "{""ok"":true,""data"":"&a&"}"
%>
