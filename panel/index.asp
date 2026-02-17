<% page_title="Ozet" %><!--#include file="../inc/layout_panel_top.inc"-->
<div class="row">
  <div class="col-lg-3 col-6"><div class="small-box bg-info"><div class="inner"><h3 id="bKontor">0</h3><p>Kalan Kontor</p></div><div class="icon"><i class="fas fa-coins"></i></div></div></div>
  <div class="col-lg-3 col-6"><div class="small-box bg-success"><div class="inner"><h3 id="bBekleyen">0</h3><p>Bekleyen</p></div><div class="icon"><i class="fas fa-ticket-alt"></i></div></div></div>
  <div class="col-lg-3 col-6"><div class="small-box bg-primary"><div class="inner"><h3 id="bKullanilan">0</h3><p>Kullanilan</p></div><div class="icon"><i class="fas fa-check-circle"></i></div></div></div>
  <div class="col-lg-3 col-6"><div class="small-box bg-warning"><div class="inner"><h3 id="bSuresiDolan">0</h3><p>Suresi Dolan</p></div><div class="icon"><i class="fas fa-hourglass-end"></i></div></div></div>
</div>
<div class="card"><div class="card-header"><h3 class="card-title">Son 7 Gun</h3></div><div class="card-body"><canvas id="cDaily" height="80"></canvas></div></div>
<!--#include file="../inc/layout_panel_bottom.inc"-->
<script>
$(function(){
  $.getJSON(ROOT_PATH + '/api/rapor_ozet.asp', function(r){ if(!r.ok)return;
    $('#bKontor').text(r.data.kontor);$('#bBekleyen').text(r.data.bekleyen);$('#bKullanilan').text(r.data.kullanilan);$('#bSuresiDolan').text(r.data.suresi_dolan);
  });
  $.getJSON(ROOT_PATH + '/api/rapor_gunluk.asp?gun=7', function(r){ if(!r.ok)return;
    new Chart(document.getElementById('cDaily'),{type:'line',data:{labels:r.data.map(x=>x.gun),datasets:[{label:'Kullanim',data:r.data.map(x=>x.kullanim),tension:.35}]},options:{responsive:true}});
  });
});
</script>
