</div>
    </div>
  </div>

  <footer class="main-footer text-sm" style="background:rgba(8,10,16,.35);border-top:1px solid rgba(255,255,255,.08);color:rgba(255,255,255,.75)">
    <div class="container d-flex justify-content-between">
      <div>© <%=Year(Now())%> 1001kupon.com</div>
      <div>Unique kupon • Panel • Rapor</div>
    </div>
  </footer>
</div>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
window.ROOT_PATH = '<%=ROOT_PATH%>';
window.kpnToast=function(msg,type){
  type=type||'success';
  Swal.fire({toast:true,position:'top-end',showConfirmButton:false,timer:2400,icon:type,title:msg});
}
</script>
</body>
</html>
