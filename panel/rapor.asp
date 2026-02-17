<% page_title="Raporlar" %><!--#include file="../inc/layout_panel_top.inc"-->
<div class="card"><div class="card-body"><pre id="out"></pre></div></div>
<script>$(function(){$.getJSON('/api/rapor_ozet.asp', r=>{ if(r.ok) $('#out').text(JSON.stringify(r.data,null,2)); });});</script>
<!--#include file="../inc/layout_panel_bottom.inc"-->
