<% page_title="Uye Ol" %><!--#include file="inc/layout_public_top.inc"-->
<div class="row justify-content-center"><div class="col-lg-9">
  <div class="card glass text-white"><div class="card-body p-4">
    <h2>Firma Kaydi</h2>
    <form id="frmReg">
      <input type="hidden" name="__csrf" value="<%=CsrfTokenGet()%>">
      <div class="row">
        <div class="col-md-6"><div class="form-group"><label>Firma Adi</label><input class="form-control" name="firma_adi" required></div></div>
        <div class="col-md-6"><div class="form-group"><label>Sektor</label><input class="form-control" name="sektor" required></div></div>
        <div class="col-md-6"><div class="form-group"><label>Yetkili Ad Soyad</label><input class="form-control" name="yetkili_ad" required></div></div>
        <div class="col-md-6"><div class="form-group"><label>Email</label><input class="form-control" name="email" type="email" required></div></div>
        <div class="col-md-6"><div class="form-group"><label>Telefon</label><input class="form-control" name="telefon"></div></div>
        <div class="col-md-6"><div class="form-group"><label>Sifre</label><input class="form-control" name="sifre" type="password" required></div></div>
      </div>
      <button class="btn btn-primary btn-block">Kayit Ol</button>
    </form>
  </div></div>
</div></div>
<!--#include file="inc/layout_public_bottom.inc"-->
<script>
$('#frmReg').on('submit', function(e){
  e.preventDefault();
  $.post(ROOT_PATH + '/api/uye_ol.asp', $(this).serialize(), function(r){
    if(r.ok){ kpnToast('Kayit tamam'); location.href=ROOT_PATH + '/panel/index.asp'; }
    else kpnToast(r.message||'Hata','error');
  }, 'json');
});
</script>
