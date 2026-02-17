<% page_title="Uye Giris" %><!--#include file="inc/layout_public_top.inc"-->
<div class="row justify-content-center"><div class="col-lg-6">
  <div class="card glass text-white"><div class="card-body p-4">
    <h2>Giris</h2>
    <form id="frmLogin">
      <input type="hidden" name="__csrf" value="<%=CsrfTokenGet()%>">
      <div class="form-group"><label>Email</label><input class="form-control" name="email" type="email" required></div>
      <div class="form-group"><label>Sifre</label><input class="form-control" name="sifre" type="password" required></div>
      <button class="btn btn-primary btn-block">Giris</button>
    </form>
  </div></div>
</div></div>
<!--#include file="inc/layout_public_bottom.inc"-->
<script>
$('#frmLogin').on('submit', function(e){
  e.preventDefault();
  $.post(ROOT_PATH + 'api/uye_giris.asp', $(this).serialize(), function(r){
    if(r.ok) location.href=ROOT_PATH + 'panel/index.asp';
    else kpnToast(r.message||'Hata','error');
  }, 'json');
});
</script>
