<!--#include file="../_config/veritabani.inc"--><!--#include file="../_config/json.inc"--><!--#include file="../_config/security.inc"-->
<% RequireLogin()
Dim conn:Set conn=DbConn()
Dim cmd:Set cmd=Server.CreateObject("ADODB.Command")
Set cmd.ActiveConnection=conn
cmd.CommandText="SELECT tanim_id,tanim_kodu,tanim_adi,aciklama,indirim_tipi,indirim_degeri,sepet_limit,gecerlilik_gun,durum FROM kupon_tanimlari WHERE firma_id=? AND silindi=0 ORDER BY tanim_id DESC"
cmd.Parameters.Append cmd.CreateParameter("@f",3,1,,CLng(Session("firma_id")))
Dim rs:Set rs=cmd.Execute
Dim a:a="[" : Dim first:first=True
Do Until rs.EOF
 If Not first Then a=a&"," Else first=False
 a=a&"{""tanim_id"":"&rs("tanim_id")&",""tanim_kodu"":"""&JsEscape(rs("tanim_kodu"))&""",""tanim_adi"":"""&JsEscape(rs("tanim_adi"))&""",""aciklama"":"""&JsEscape(rs("aciklama"))&""",""indirim_tipi"":"&rs("indirim_tipi")&",""indirim_degeri"":"&Replace(CStr(rs("indirim_degeri")),",",".")&",""sepet_limit"":"&Replace(CStr(rs("sepet_limit")),",",".")&",""gecerlilik_gun"":"&rs("gecerlilik_gun")&",""durum"":"&rs("durum")&"}"
 rs.MoveNext
Loop
a=a&"]"
JsonWrite "{""ok"":true,""data"":"&a&"}"
%>
