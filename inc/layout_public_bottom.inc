</main>
<footer class="bg-slate-950 border-t border-white/5 pt-20 pb-10 mt-auto">
<div class="max-w-7xl mx-auto px-6">
<div class="grid grid-cols-2 md:grid-cols-5 gap-12 mb-20">
<div class="col-span-2 space-y-6">
<div class="flex items-center gap-2">
<div class="bg-gradient-to-tr from-accent-start to-accent-end p-2 rounded-lg text-white">
<span class="material-symbols-outlined block">confirmation_number</span>
</div>
<span class="text-xl font-bold tracking-tight text-white">1001Kupon</span>
</div>
<p class="text-slate-500 max-w-xs leading-relaxed">
                    Dünyanın en güvenilir ve hızlı kupon yönetim platformu. Geleceğin sadakat programlarını bugünden inşa edin.
                </p>
<div class="flex gap-4">
<a class="w-10 h-10 rounded-full border border-white/10 flex items-center justify-center text-slate-400 hover:border-accent-start hover:text-accent-start transition-all" href="#">
<span class="material-symbols-outlined text-xl">share</span>
</a>
<a class="w-10 h-10 rounded-full border border-white/10 flex items-center justify-center text-slate-400 hover:border-accent-start hover:text-accent-start transition-all" href="#">
<span class="material-symbols-outlined text-xl">public</span>
</a>
<a class="w-10 h-10 rounded-full border border-white/10 flex items-center justify-center text-slate-400 hover:border-accent-start hover:text-accent-start transition-all" href="#">
<span class="material-symbols-outlined text-xl">alternate_email</span>
</a>
</div>
</div>
<div>
<h6 class="font-bold text-white mb-6 uppercase text-xs tracking-widest">Ürün</h6>
<ul class="space-y-4 text-sm text-slate-500 font-medium">
<li><a class="hover:text-accent-start" href="#">Özellikler</a></li>
<li><a class="hover:text-accent-start" href="#">API Dokümanı</a></li>
<li><a class="hover:text-accent-start" href="#">Fiyatlandırma</a></li>
<li><a class="hover:text-accent-start" href="#">Versiyon Geçmişi</a></li>
</ul>
</div>
<div>
<h6 class="font-bold text-white mb-6 uppercase text-xs tracking-widest">Şirket</h6>
<ul class="space-y-4 text-sm text-slate-500 font-medium">
<li><a class="hover:text-accent-start" href="<%=ROOT_PATH%>/hakkimizda.asp">Hakkımızda</a></li>
<li><a class="hover:text-accent-start" href="#">Kariyer</a></li>
<li><a class="hover:text-accent-start" href="#">Blog</a></li>
<li><a class="hover:text-accent-start" href="<%=ROOT_PATH%>/basvuru.asp">İletişim</a></li>
</ul>
</div>
<div>
<h6 class="font-bold text-white mb-6 uppercase text-xs tracking-widest">Yasal</h6>
<ul class="space-y-4 text-sm text-slate-500 font-medium">
<li><a class="hover:text-accent-start" href="#">KVKK</a></li>
<li><a class="hover:text-accent-start" href="#">Kullanım Koşulları</a></li>
<li><a class="hover:text-accent-start" href="#">Çerez Politikası</a></li>
</ul>
</div>
</div>
<div class="pt-10 border-t border-white/5 flex flex-col md:flex-row justify-between items-center gap-4 text-slate-500 text-xs font-semibold">
<p>© <%=Year(Now())%> 1001Kupon. Tüm hakları saklıdır.</p>
<div class="flex items-center gap-2">
<span class="w-2 h-2 rounded-full bg-emerald-500 shadow-[0_0_8px_rgba(16,185,129,0.5)]"></span>
                Tüm Sistemler Çalışıyor
            </div>
</div>
</div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
window.ROOT_PATH = '<%=ROOT_PATH%>';
window.kpnToast=function(msg,type){
  type=type||'success';
  const colors = {success: '#10b981', error: '#ef4444', warning: '#f59e0b', info: '#3b82f6'};
  Swal.fire({
    toast:true,
    position:'top-end',
    showConfirmButton:false,
    timer:3000,
    title: msg,
    icon: type,
    background: '#1e293b',
    color: '#fff',
    iconColor: colors[type] || colors.info
  });
}
</script>
</body>
</html>
