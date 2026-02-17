<%
Function CsrfTokenGet()
  If IsEmpty(Session("csrf")) Or IsNull(Session("csrf")) Or Len(Session("csrf"))=0 Then
    Session("csrf") = Replace(Replace(CreateObject("Scriptlet.TypeLib").Guid,"{",""),"}","")
  End If
  CsrfTokenGet = Session("csrf")
End Function

Sub CsrfValidate()
  Dim sent: sent = Request.Form("__csrf")
  If Len(sent)=0 Then
    Response.Status="400 Bad Request"
    Response.Write "CSRF missing"
    Response.End
  End If
  If CStr(sent) <> CStr(CsrfTokenGet()) Then
    Response.Status="403 Forbidden"
    Response.Write "CSRF invalid"
    Response.End
  End If
End Sub

Function IsLoggedIn()
  IsLoggedIn = (Not IsEmpty(Session("kullanici_id")) And Len(Session("kullanici_id"))>0)
End Function

Sub RequireLogin()
  If Not IsLoggedIn() Then
    Response.Redirect "/uye-giris.asp"
    Response.End
  End If
End Sub
%>
