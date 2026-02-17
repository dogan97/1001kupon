# 1001Kupon Projesi - Analiz ve Kurulum Raporu

## 1. Mimari Analizi
Proje, Classic ASP (VBScript) ve SQL Server tabanlı modern bir yapıya sahiptir.
- **Frontend**: HTML5, jQuery ve Bootstrap kullanılarak AJAX tabanlı bir SPA (Single Page Application) benzeri deneyim sunulmaktadır.
- **Backend**: `/api` klasörü altındaki ASP dosyaları, JSON formatında yanıt dönen REST-like endpoint'ler olarak çalışmaktadır.
- **Veritabanı**: `/sql/schema.sql` dosyasında tanımlı, ilişkisel ve Stored Procedure'lere dayalı güvenli bir yapı mevcuttur.
- **Güvenlik**: `_config/security.inc` içerisinde CSRF koruması ve Oturum (Session) yönetimi merkezi olarak sağlanmıştır.

## 2. Yapılan Düzeltmeler ve İyileştirmeler

Analiz sırasında tespit edilen bazı kritik hatalar düzeltilmiştir:

1.  **Sözdizimi Hataları (Syntax Errors)**:
    - `api/kupon_uret.asp`, `api/uye_giris.asp` ve `api/kupon_oldur.asp` dosyalarında `If ... Else ... End If` bloklarının yanlış kullanımı (tek satırda çoklu blok hatası) düzeltildi. Kodlar güvenli ve okunabilir çok satırlı bloklara dönüştürüldü.
    - `api/kupon_list.asp` dosyasındaki gereksiz `End If` kaldırıldı.

2.  **Hata Yönetimi (Error Handling)**:
    - Kritik veritabanı işlemleri (`api/uye_ol.asp`, `api/kupon_uret.asp`) `On Error Resume Next` bloğu içine alınarak, SQL seviyesindeki hataların (örn. mükerrer email kaydı) 500 sunucu hatası vermek yerine anlamlı JSON hata mesajları döndürmesi sağlandı.

3.  **Veritabanı ve Güvenlik Uyumu**:
    - Tüm API çağrılarının `dbo.sp_...` stored procedure isimleriyle ve parametre sıralarıyla birebir uyumlu olduğu doğrulandı.
    - `ADODB.Command` nesnesi kullanılarak SQL Injection riskine karşı tam koruma sağlandığı teyit edildi.
    - Frontend formlarında `CsrfTokenGet()` ve backend tarafında `CsrfValidate()` kullanımının aktif olduğu doğrulandı.

## 3. IIS Kurulum Adımları (Eylem Planı)

Projeyi yerel IIS sunucusunda çalıştırmak için aşağıdaki adımları izleyin:

### Adım 1: Veritabanı Kurulumu
1.  SQL Server Management Studio (SSMS) uygulamasını açın.
2.  `sql/schema.sql` dosyasını açın ve çalıştırın (F5).
3.  Bu işlem `KUPON1001` veritabanını, tabloları ve gerekli Stored Procedure'leri oluşturacaktır.
4.  `_config/veritabani.inc` dosyasındaki `DB_CONN_STR` değişkenini kendi SQL Server ayarlarınıza göre güncelleyin (gerekirse).
    *   Varsayılan: `Server=.;Database=KUPON1001;Trusted_Connection=Yes;`

### Adım 2: IIS Ayarları
1.  **IIS Manager**'ı açın.
2.  **Sites** üzerine sağ tıklayın -> **Add Website**.
    *   **Site Name**: `1001Kupon`
    *   **Physical Path**: Projenin bulunduğu klasör (C:\Users\...\1001kupon_classic_asp_pro_full)
    *   **Port**: 8080 (veya boş bir port)
3.  **Application Pool** ayarlarına gidin:
    *   Oluşturulan `1001Kupon` havuzuna çift tıklayın.
    *   **Enable 32-Bit Applications**: `True` (Eski ODBC sürücüleri kullanıyorsanız gerekebilir, genellikle False kalsın).
    *   **Managed Pipeline Mode**: `Integrated`.
4.  **ASP Ayarları**:
    *   Site ana ekranında **ASP** simgesine çift tıklayın.
    *   **Enable Parent Paths**: `True` yapın (Dosya yollarında `../` kullanımı için gereklidir).
    *   **Debugging Properties** -> **Send Errors To Browser**: `True` (Geliştirme aşaması için).

### Adım 3: Test
1.  Tarayıcınızda `http://localhost:8080/uye-giris.asp` adresine gidin.
2.  "Kayıt Ol" sayfasından yeni bir firma hesabı oluşturun.
3.  Panel üzerinden kupon tanımlayıp üretmeyi deneyin.

Proje kullanıma hazırdır.
