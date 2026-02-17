<!--#include file="../_config/security.inc"-->
<!doctype html>
<html lang="tr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title><%=Server.HTMLEncode(page_title)%> - 1001Kupon</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.2/css/all.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">
  <style>
    body{background:#0b1220;}
    .brand-gradient{background:linear-gradient(90deg,#3b82f6,#06b6d4);-webkit-background-clip:text;background-clip:text;color:transparent;font-weight:900}
    .glass{background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.08);border-radius:14px}
  </style>
</head>
<body class="layout-top-nav">
<div class="wrapper">
  <nav class="main-header navbar navbar-expand navbar-dark" style="background:rgba(10,14,25,.85);border-bottom:1px solid rgba(255,255,255,.08)">
    <div class="container">
      <a href="<%=ROOT_PATH%>/index.asp" class="navbar-brand"><span class="brand-gradient">1001Kupon</span></a>
      <ul class="navbar-nav ml-auto">
        <li class="nav-item"><a class="nav-link" href="<%=ROOT_PATH%>/hakkimizda.asp">Hakkimizda</a></li>
        <li class="nav-item"><a class="nav-link" href="<%=ROOT_PATH%>/basvuru.asp">Basvuru</a></li>
        <% If IsLoggedIn() Then %>
          <li class="nav-item"><a class="nav-link" href="<%=ROOT_PATH%>/panel/index.asp">Panel</a></li>
          <li class="nav-item"><a class="nav-link" href="<%=ROOT_PATH%>/api/cikis.asp">Cikis</a></li>
        <% Else %>
          <li class="nav-item"><a class="nav-link" href="<%=ROOT_PATH%>/uye-giris.asp">Giris</a></li>
          <li class="nav-item"><a class="btn btn-sm btn-primary ml-2" href="<%=ROOT_PATH%>/uye-ol.asp">Uye Ol</a></li>
        <% End If %>
      </ul>
    </div>
  </nav>

  <div class="content-wrapper" style="background:transparent;">
    <div class="content pt-4 pb-5">
      <div class="container">
