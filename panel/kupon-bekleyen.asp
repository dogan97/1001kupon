<% page_title="Bekleyen Kuponlar" %><!--#include file="../inc/layout_panel_top.inc"-->
<div class="card"><div class="card-body"><table id="tbl" class="table table-bordered table-striped"><thead><tr><th>Kod</th><th>Tanim</th><th>Bitis</th><th></th></tr></thead><tbody></tbody></table></div></div>
<!--#include file="../inc/layout_panel_bottom.inc"-->
<script>
$(function(){
  const t=$('#tbl').DataTable({columns:[{data:'kupon_kodu'},{data:'tanim_adi'},{data:'bitis_tarihi'},{data:null,orderable:false,render:d=>`<button class="btn btn-success btn-sm" data-k="${d.kupon_kodu}">Oldur</button>`}]});
  $.getJSON(ROOT_PATH + '/api/kupon_list.asp?durum=bekleyen&limit=500', r=>{ if(r.ok) t.rows.add(r.data).draw(); });
  $('#tbl').on('click','button[data-k]', function(){
    kpnPost('/api/kupon_oldur.asp',{kupon_kodu:$(this).data('k'),siparis_no:'',sepet_tutar:''}).done(r=>{ if(r.ok) location.reload(); else kpnToast(r.message,'error'); });
  });
});
</script>
