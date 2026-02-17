<!--#include file="../_config/security.inc"-->
<% RequireLogin() %>
<!doctype html>
<html lang="tr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title><%=Server.HTMLEncode(page_title)%> - 1001Kupon Panel</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.2/css/all.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/datatables.net-bs4@1.13.8/css/dataTables.bootstrap4.min.css">
  <style>
    body{background:#0b1220;}
    .brand-gradient{background:linear-gradient(90deg,#3b82f6,#06b6d4);-webkit-background-clip:text;background-clip:text;color:transparent;font-weight:900}
    .card{border-radius:14px}
  </style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
  <nav class="main-header navbar navbar-expand navbar-dark" style="background:rgba(10,14,25,.85);border-bottom:1px solid rgba(255,255,255,.08)">
    <ul class="navbar-nav"><li class="nav-item"><a class="nav-link" data-widget="pushmenu" href="#"><i class="fas fa-bars"></i></a></li></ul>
    <ul class="navbar-nav ml-auto">
      <li class="nav-item d-none d-sm-inline-block"><a class="nav-link" href="<%=ROOT_PATH%>/index.asp" target="_blank"><i class="fa fa-globe mr-1"></i>Site</a></li>
      <li class="nav-item"><a class="nav-link" href="<%=ROOT_PATH%>/api/cikis.asp"><i class="fa fa-sign-out-alt mr-1"></i>Cikis</a></li>
    </ul>
  </nav>

  <aside class="main-sidebar sidebar-dark-primary elevation-4" style="background:rgba(10,14,25,.95);">
    <a href="<%=ROOT_PATH%>/panel/index.asp" class="brand-link" style="border-bottom:1px solid rgba(255,255,255,.08)">
      <span class="brand-gradient ml-2">1001Kupon</span>
    </a>
    <div class="sidebar">
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column">
          <li class="nav-item"><a href="<%=ROOT_PATH%>/panel/index.asp" class="nav-link"><i class="nav-icon fas fa-chart-pie"></i><p>Ozet</p></a></li>
          <li class="nav-item"><a href="<%=ROOT_PATH%>/panel/kupon-tanim.asp" class="nav-link"><i class="nav-icon fas fa-puzzle-piece"></i><p>Kupon Tanimlama</p></a></li>
          <li class="nav-item"><a href="<%=ROOT_PATH%>/panel/kupon-uret.asp" class="nav-link"><i class="nav-icon fas fa-cogs"></i><p>Kupon Uretme</p></a></li>
          <li class="nav-item"><a href="<%=ROOT_PATH%>/panel/odeme.asp" class="nav-link"><i class="nav-icon fas fa-credit-card"></i><p>Online Odeme</p></a></li>
          <li class="nav-item"><a href="<%=ROOT_PATH%>/panel/kupon-bekleyen.asp" class="nav-link"><i class="nav-icon fas fa-ticket-alt"></i><p>Bekleyen Kuponlar</p></a></li>
          <li class="nav-item"><a href="<%=ROOT_PATH%>/panel/kupon-kullanilan.asp" class="nav-link"><i class="nav-icon fas fa-check-circle"></i><p>Kullanilan Kuponlar</p></a></li>
          <li class="nav-item"><a href="<%=ROOT_PATH%>/panel/rapor.asp" class="nav-link"><i class="nav-icon fas fa-chart-line"></i><p>Raporlar</p></a></li>
        </ul>
      </nav>
    </div>
  </aside>

  <div class="content-wrapper" style="background:transparent;">
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6"><h1 class="text-white"><%=Server.HTMLEncode(page_title)%></h1></div>
        </div>
      </div>
    </section>
    <section class="content"><div class="container-fluid">
