<%
Response.CodePage = 65001
Response.CharSet = "utf-8"

Function JsEscape(s)
  If IsNull(s) Then s = ""
  s = CStr(s)
  s = Replace(s, "\", "\\")
  s = Replace(s, Chr(34), "\" & Chr(34))
  s = Replace(s, vbCrLf, "\n")
  s = Replace(s, vbCr, "\n")
  s = Replace(s, vbLf, "\n")
  JsEscape = s
End Function

Sub JsonWriteOk(msg)
  Response.ContentType = "application/json"
  Response.Write "{""ok"":true,""message"":""" & JsEscape(msg) & """}"
End Sub

Sub JsonWriteErr(msg)
  Response.ContentType = "application/json"
  Response.Write "{""ok"":false,""message"":""" & JsEscape(msg) & """}"
End Sub

Sub JsonWrite(objJson)
  Response.ContentType = "application/json"
  Response.Write objJson
End Sub
%>
