<% page_title="Online Odeme" %><!--#include file="../inc/layout_panel_top.inc"-->
<div class="row"><div class="col-md-4"><div class="card"><div class="card-body"><h5>1000 Kontor</h5><button class="btn btn-primary btn-block" onclick="buy(1000)">Satin Al</button></div></div></div>
<div class="col-md-4"><div class="card"><div class="card-body"><h5>10000 Kontor</h5><button class="btn btn-primary btn-block" onclick="buy(10000)">Satin Al</button></div></div></div>
<div class="col-md-4"><div class="card"><div class="card-body"><h5>100000 Kontor</h5><button class="btn btn-primary btn-block" onclick="buy(100000)">Satin Al</button></div></div></div></div>
<script>function buy(p){kpnPost('/api/odeme_stub.asp',{paket:p}).done(r=>{if(r.ok)location.href='/panel/index.asp';else kpnToast(r.message,'error');});}</script>
<!--#include file="../inc/layout_panel_bottom.inc"-->
