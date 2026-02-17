<% page_title="Uye Giris" %><!--#include file="inc/layout_public_top.inc"-->
<div class="flex items-center justify-center min-h-[calc(100vh-200px)] py-12 px-6 relative overflow-hidden">
  <div class="absolute -top-24 -left-24 w-96 h-96 bg-accent-start/20 blur-[100px] rounded-full"></div>
  <div class="absolute -bottom-24 -right-24 w-96 h-96 bg-accent-end/20 blur-[100px] rounded-full"></div>
  
  <div class="glass-card w-full max-w-md p-8 rounded-2xl relative z-10 shadow-2xl">
    <div class="text-center mb-8">
      <h2 class="text-3xl font-black text-white mb-2 tracking-tight">Giriş Yap</h2>
      <p class="text-slate-400">Hesabınıza erişmek için bilgilerinizi girin.</p>
    </div>
    
    <form id="frmLogin" class="space-y-6">
      <input type="hidden" name="__csrf" value="<%=CsrfTokenGet()%>">
      <div class="space-y-2">
        <label class="text-xs font-bold text-slate-500 uppercase tracking-wider">E-posta</label>
        <input class="w-full bg-slate-900/50 border border-white/10 rounded-lg focus:ring-2 focus:ring-accent-start focus:border-accent-start px-4 py-3 text-white transition-all outline-none" name="email" type="email" placeholder="ornek@sirket.com" required>
      </div>
      <div class="space-y-2">
        <label class="text-xs font-bold text-slate-500 uppercase tracking-wider">Şifre</label>
        <input class="w-full bg-slate-900/50 border border-white/10 rounded-lg focus:ring-2 focus:ring-accent-start focus:border-accent-start px-4 py-3 text-white transition-all outline-none" name="sifre" type="password" placeholder="••••••••" required>
      </div>
      <button class="w-full gradient-button text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-accent-start/25">Giriş Yap</button>
    </form>
    
    <div class="mt-6 text-center text-sm text-slate-500">
      Hesabınız yok mu? <a href="<%=ROOT_PATH%>/uye-ol.asp" class="text-accent-start font-bold hover:text-accent-end transition-colors">Hemen Kayıt Olun</a>
    </div>
  </div>
</div>
<!--#include file="inc/layout_public_bottom.inc"-->
<script>
$('#frmLogin').on('submit', function(e){
  e.preventDefault();
  const btn = $(this).find('button');
  const originalText = btn.text();
  btn.prop('disabled', true).html('<span class="material-symbols-outlined animate-spin text-sm">sync</span> Giriş Yapılıyor...');
  
  $.post(ROOT_PATH + '/api/uye_giris.asp', $(this).serialize(), function(r){
    if(r.ok) location.href=ROOT_PATH + '/panel/index.asp';
    else {
      kpnToast(r.message||'Hata','error');
      btn.prop('disabled', false).text(originalText);
    }
  }, 'json').fail(function(){
    kpnToast('Sunucu hatası oluştu','error');
    btn.prop('disabled', false).text(originalText);
  });
});
</script>
