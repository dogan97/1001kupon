<% page_title="Kupon Tanimlama" %><!--#include file="../inc/layout_panel_top.inc"-->
<div class="card"><div class="card-header d-flex justify-content-between"><h3 class="card-title">Tanimlar</h3><button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#mDef">Yeni</button></div>
<div class="card-body"><table id="tbl" class="table table-bordered table-striped"><thead><tr><th>Kod</th><th>Ad</th><th>Tip</th><th>Deger</th><th>Durum</th></tr></thead><tbody></tbody></table></div></div>
<div class="modal fade" id="mDef"><div class="modal-dialog"><div class="modal-content"><div class="modal-header"><h5 class="modal-title">Yeni</h5><button class="close" data-dismiss="modal"><span>&times;</span></button></div>
<div class="modal-body"><form id="frmDef"><input type="hidden" name="__csrf" value="<%=CsrfTokenGet()%>">
<div class="form-group"><label>Adi</label><input class="form-control" name="tanim_adi" required></div>
<div class="form-row"><div class="form-group col-6"><label>Tip</label><select class="form-control" name="indirim_tipi"><option value="1">Tutar</option><option value="2">Yuzde</option></select></div>
<div class="form-group col-6"><label>Deger</label><input class="form-control" name="indirim_degeri" type="number" min="1" required></div></div>
<div class="form-row"><div class="form-group col-6"><label>Gecerlilik (gun)</label><input class="form-control" name="gecerlilik_gun" type="number" value="30"></div>
<div class="form-group col-6"><label>Sepet Limit</label><input class="form-control" name="sepet_limit" type="number" value="0"></div></div>
<button class="btn btn-primary btn-block">Kaydet</button></form></div></div></div></div>
<!--#include file="../inc/layout_panel_bottom.inc"-->
<script>
$(function(){
  const t=$('#tbl').DataTable({columns:[{data:'tanim_kodu'},{data:'tanim_adi'},{data:'indirim_tipi'},{data:'indirim_degeri'},{data:'durum'}]});
  $.getJSON(ROOT_PATH + '/api/kupon_tanim_list.asp', r=>{ if(r.ok) t.rows.add(r.data).draw(); });
  $('#frmDef').on('submit', function(e){ e.preventDefault();
    $.post(ROOT_PATH + '/api/kupon_tanim_ekle.asp', $(this).serialize(), r=>{ if(r.ok) location.reload(); else kpnToast(r.message,'error'); }, 'json');
  });
});
</script>
