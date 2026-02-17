<!--#include file="../_config/veritabani.inc"--><!--#include file="../_config/json.inc"--><!--#include file="../_config/security.inc"-->
<% RequireLogin()
Dim durum: durum=LCase(Trim(Request.QueryString("durum")))
Dim st: If durum="kullanilan" Then st=2 Else st=1
Dim lim: lim=CLng(Request.QueryString("limit")): If lim<=0 Or lim>2000 Then lim=200
Dim conn:Set conn=DbConn()
Dim cmd:Set cmd=Server.CreateObject("ADODB.Command")
Set cmd.ActiveConnection=conn
cmd.CommandText="SELECT TOP " & lim & " k.kupon_kodu,CONVERT(varchar(10),k.bitis_tarihi,120) bitis_tarihi,CONVERT(varchar(10),k.kullanma_tarihi,120) kullanma_tarihi,t.tanim_adi FROM kuponlar k INNER JOIN kupon_tanimlari t ON t.tanim_id=k.tanim_id WHERE k.firma_id=? AND k.durum=? ORDER BY k.kupon_id DESC"
cmd.Parameters.Append cmd.CreateParameter("@f",3,1,,CLng(Session("firma_id")))
cmd.Parameters.Append cmd.CreateParameter("@d",3,1,,st)
Dim rs:Set rs=cmd.Execute
Dim a:a="[" : Dim first:first=True
Do Until rs.EOF
 If Not first Then a=a&"," Else first=False
 a=a&"{""kupon_kodu"":"""&JsEscape(rs("kupon_kodu"))&""",""bitis_tarihi"":"""&rs("bitis_tarihi")&""",""kullanma_tarihi"":"""&rs("kullanma_tarihi")&""",""tanim_adi"":"""&JsEscape(rs("tanim_adi"))&"""}"
 rs.MoveNext
Loop
a=a&"]"
JsonWrite "{""ok"":true,""data"":"&a&"}"
%>
