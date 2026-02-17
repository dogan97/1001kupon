<% page_title="Uye Ol" %><!--#include file="inc/layout_public_top.inc"-->
<div class="flex items-center justify-center min-h-[calc(100vh-200px)] py-12 px-6 relative overflow-hidden">
  <div class="absolute -top-24 -right-24 w-96 h-96 bg-accent-start/20 blur-[100px] rounded-full"></div>
  <div class="absolute -bottom-24 -left-24 w-96 h-96 bg-accent-end/20 blur-[100px] rounded-full"></div>

  <div class="glass-card w-full max-w-2xl p-8 sm:p-10 rounded-2xl relative z-10 shadow-2xl">
    <div class="text-center mb-8">
      <h2 class="text-3xl font-black text-white mb-2 tracking-tight">Firma Hesabı Oluştur</h2>
      <p class="text-slate-400">1001Kupon dünyasına katılın, kampanyalarınızı yönetmeye başlayın.</p>
    </div>

    <form id="frmReg" class="space-y-6">
      <input type="hidden" name="__csrf" value="<%=CsrfTokenGet()%>">
      <div class="grid md:grid-cols-2 gap-6">
        <div class="space-y-2">
          <label class="text-xs font-bold text-slate-500 uppercase tracking-wider">Firma Adı</label>
          <input class="w-full bg-slate-900/50 border border-white/10 rounded-lg focus:ring-2 focus:ring-accent-start focus:border-accent-start px-4 py-3 text-white transition-all outline-none" name="firma_adi" required placeholder="Şirketiniz A.Ş.">
        </div>
        <div class="space-y-2">
          <label class="text-xs font-bold text-slate-500 uppercase tracking-wider">Sektör</label>
          <input class="w-full bg-slate-900/50 border border-white/10 rounded-lg focus:ring-2 focus:ring-accent-start focus:border-accent-start px-4 py-3 text-white transition-all outline-none" name="sektor" required placeholder="E-ticaret, Perakende...">
        </div>
        <div class="space-y-2">
          <label class="text-xs font-bold text-slate-500 uppercase tracking-wider">Yetkili Ad Soyad</label>
          <input class="w-full bg-slate-900/50 border border-white/10 rounded-lg focus:ring-2 focus:ring-accent-start focus:border-accent-start px-4 py-3 text-white transition-all outline-none" name="yetkili_ad" required placeholder="Adınız Soyadınız">
        </div>
        <div class="space-y-2">
          <label class="text-xs font-bold text-slate-500 uppercase tracking-wider">Telefon</label>
          <input class="w-full bg-slate-900/50 border border-white/10 rounded-lg focus:ring-2 focus:ring-accent-start focus:border-accent-start px-4 py-3 text-white transition-all outline-none" name="telefon" placeholder="0555 555 55 55">
        </div>
        <div class="space-y-2">
          <label class="text-xs font-bold text-slate-500 uppercase tracking-wider">E-posta</label>
          <input class="w-full bg-slate-900/50 border border-white/10 rounded-lg focus:ring-2 focus:ring-accent-start focus:border-accent-start px-4 py-3 text-white transition-all outline-none" name="email" type="email" required placeholder="ornek@sirket.com">
        </div>
        <div class="space-y-2">
          <label class="text-xs font-bold text-slate-500 uppercase tracking-wider">Şifre</label>
          <input class="w-full bg-slate-900/50 border border-white/10 rounded-lg focus:ring-2 focus:ring-accent-start focus:border-accent-start px-4 py-3 text-white transition-all outline-none" name="sifre" type="password" required placeholder="Güçlü bir şifre seçin">
        </div>
      </div>
      <div class="pt-4">
        <button class="w-full gradient-button text-white font-bold py-4 rounded-xl transition-all shadow-lg hover:shadow-accent-start/25">Hesabı Oluştur</button>
      </div>
    </form>
    
    <div class="mt-6 text-center text-sm text-slate-500">
      Zaten hesabınız var mı? <a href="<%=ROOT_PATH%>/uye-giris.asp" class="text-accent-start font-bold hover:text-accent-end transition-colors">Giriş Yapın</a>
    </div>
  </div>
</div>
<!--#include file="inc/layout_public_bottom.inc"-->
<script>
$('#frmReg').on('submit', function(e){
  e.preventDefault();
  const btn = $(this).find('button');
  const originalText = btn.text();
  btn.prop('disabled', true).html('<span class="material-symbols-outlined animate-spin text-sm">sync</span> Kayıt Yapılıyor...');

  $.post(ROOT_PATH + '/api/uye_ol.asp', $(this).serialize(), function(r){
    if(r.ok){ 
      kpnToast('Kayıt Başarılı! Yönlendiriliyorsunuz...'); 
      setTimeout(() => location.href=ROOT_PATH + '/panel/index.asp', 1500);
    }
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
