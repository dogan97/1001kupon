<% page_title="Kupon Uretme" %><!--#include file="../inc/layout_panel_top.inc"-->
<div class="card"><div class="card-body"><form id="frmGen"><input type="hidden" name="__csrf" value="<%=CsrfTokenGet()%>">
<div class="form-group"><label>Tanim</label><select class="form-control" name="tanim_id" id="selDef"></select></div>
<div class="form-group"><label>Adet</label><input class="form-control" name="adet" type="number" value="1000"></div>
<button class="btn btn-primary btn-block">Uret</button></form></div></div>
<!--#include file="../inc/layout_panel_bottom.inc"-->
<script>
$(function(){
  $.getJSON(ROOT_PATH + '/api/kupon_tanim_list.asp', r=>{ if(!r.ok) return; const s=$('#selDef'); r.data.forEach(d=>s.append(`<option value="${d.tanim_id}">${d.tanim_kodu} - ${d.tanim_adi}</option>`)); });
  $('#frmGen').on('submit', function(e){ e.preventDefault();
    $.post(ROOT_PATH + '/api/kupon_uret.asp', $(this).serialize(), r=>{ if(r.ok) kpnToast('Batch '+r.batch_id); else kpnToast(r.message,'error'); }, 'json');
  });
});
</script>
