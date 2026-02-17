<% page_title="Kullanilan Kuponlar" %><!--#include file="../inc/layout_panel_top.inc"-->
<div class="card"><div class="card-body"><table id="tbl" class="table table-bordered table-striped"><thead><tr><th>Kod</th><th>Tanim</th><th>Tarih</th></tr></thead><tbody></tbody></table></div></div>
<!--#include file="../inc/layout_panel_bottom.inc"-->
<script>
$(function(){
  const t=$('#tbl').DataTable({columns:[{data:'kupon_kodu'},{data:'tanim_adi'},{data:'kullanma_tarihi'}]});
  $.getJSON(ROOT_PATH + '/api/kupon_list.asp?durum=kullanilan&limit=500', r=>{ if(r.ok) t.rows.add(r.data).draw(); });
});
</script>
