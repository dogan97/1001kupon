<!--#include file="../_config/veritabani.inc"-->
<!--#include file="../_config/security.inc"-->
<!DOCTYPE html>
<html lang="tr" class="scroll-smooth">
<head>
<meta charset="utf-8"/>
<meta content="width=device-width, initial-scale=1.0" name="viewport"/>
<title><%=Server.HTMLEncode(page_title)%></title>
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&amp;display=swap" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap" rel="stylesheet"/>
<script>
    tailwind.config = {
        darkMode: "class",
        theme: {
            extend: {
                colors: {
                    "primary": "#0d33f2",
                    "accent-start": "#3b82f6",
                    "accent-end": "#a855f7",
                    "dark-bg": "#0F172A",
                    "dark-card": "#1E293B",
                    "dark-border": "rgba(255,255,255,0.1)",
                },
                fontFamily: {
                    "display": ["Inter", "sans-serif"]
                },
            },
        },
    }
</script>
<style type="text/tailwindcss">
    body { 
        font-family: 'Inter', sans-serif; 
        background-color: #0F172A;
        color: #f8fafc;
    }
    .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
    .hero-glow {
        background: radial-gradient(circle at 50% -20%, rgba(59, 130, 246, 0.15), transparent 70%),
                    radial-gradient(circle at 0% 100%, rgba(168, 85, 247, 0.1), transparent 50%);
    }
    .gradient-button {
        background: linear-gradient(135deg, #3b82f6 0%, #a855f7 100%);
        box-shadow: 0 0 20px rgba(59, 130, 246, 0.4);
    }
    .gradient-button:hover {
        box-shadow: 0 0 30px rgba(168, 85, 247, 0.6);
        transform: translateY(-1px);
    }
    .glass-card {
        background: rgba(30, 41, 59, 0.7);
        backdrop-filter: blur(12px);
        border: 1px solid rgba(255, 255, 255, 0.08);
    }
    .neon-border-hover:hover {
        border-color: rgba(59, 130, 246, 0.5);
        box-shadow: 0 0 15px rgba(59, 130, 246, 0.2);
    }
    .code-block {
        background: #020617;
        border: 1px solid rgba(255,255,255,0.1);
    }
</style>
</head>
<body class="font-display selection:bg-accent-start selection:text-white flex flex-col min-h-screen">
<nav class="sticky top-0 z-50 w-full bg-dark-bg/80 backdrop-blur-md border-b border-white/5">
<div class="max-w-7xl mx-auto px-6 h-20 flex items-center justify-between">
<a href="<%=ROOT_PATH%>/index.asp" class="flex items-center gap-2 group cursor-pointer">
<div class="bg-gradient-to-tr from-accent-start to-accent-end p-2 rounded-lg text-white">
<span class="material-symbols-outlined block">confirmation_number</span>
</div>
<span class="text-xl font-bold tracking-tight text-white">1001Kupon</span>
</a>
<div class="hidden md:flex items-center gap-8">
<a class="text-sm font-semibold text-slate-400 hover:text-white transition-colors" href="<%=ROOT_PATH%>/index.asp#ozellikler">Özellikler</a>
<a class="text-sm font-semibold text-slate-400 hover:text-white transition-colors" href="<%=ROOT_PATH%>/index.asp#sektorler">Sektörler</a>
<a class="text-sm font-semibold text-slate-400 hover:text-white transition-colors" href="<%=ROOT_PATH%>/index.asp#fiyat">Fiyatlandırma</a>
<a class="text-sm font-semibold text-slate-400 hover:text-white transition-colors" href="<%=ROOT_PATH%>/hakkimizda.asp">Hakkımızda</a>
</div>
<div class="flex items-center gap-4">
<% If IsLoggedIn() Then %>
<a class="gradient-button text-white px-6 py-2.5 rounded-lg text-sm font-bold transition-all" href="<%=ROOT_PATH%>/panel/index.asp">Panele Git</a>
<% Else %>
<a class="hidden sm:block text-sm font-bold text-slate-400 hover:text-white" href="<%=ROOT_PATH%>/uye-giris.asp">Giriş Yap</a>
<a class="gradient-button text-white px-6 py-2.5 rounded-lg text-sm font-bold transition-all" href="<%=ROOT_PATH%>/uye-ol.asp">Hemen Başla</a>
<% End If %>
</div>
</div>
</nav>
<main class="flex-grow">
