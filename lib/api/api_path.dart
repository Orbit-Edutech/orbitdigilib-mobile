class APIPath {
  static const base = "https://api.orbitdigilib.com";
  // static const base = "https://api-dev.orbitdigilib.com"; // base API for dev (localhost)

  /// /asset/{id}
  static String asset(String id) => "$base/asset/$id";

  /// /asset/public/{id}
  static String publicAsset(String id) => "$base/asset/public/$id";

  /// /auth
  static const auth = "/auth";

  /// /auth/validate
  static const validate = "$auth/validate";

  /// /auth/login
  static const login = "$auth/login";

  /// /auth/logout
  static const logout = "$auth/logout";

  /// /auth/forgot-password
  static const forgotPassword = "$auth/forgot-password";

  /// /auth/change-password
  static const changePassword = "$auth/change-password";

  /// /auth/refresh
  static const refresh = "$auth/refresh";

  /// /auth/profile
  static const profile = "$auth/profile";

  /// /perpustakaan
  static const perpustakaan = "/perpustakaan";

  /// /perpustakaan/{kode}
  static String perpustakaanGetOne(String kode) => "$perpustakaan/$kode";

  /// /buku-perpustakaan
  static const allBukuPerpus = "/buku-perpustakaan";

  /// /buku-perpustakaan/{id}
  static oneBukuPerpus(String id) => "/buku-perpustakaan/$id";

  /// /buku/{id}
  static oneBuku(String id) => "/buku/$id";

  /// /perpustakaan/default/banner
  static const bannerDefault = "/perpustakaan/default/banner";

  /// /pinjam
  static const pinjam = "/pinjam";

  /// /sewa
  static const sewa = "/sewa";

  /// /beli
  static const beli = "/beli";

  /// /katalog-buku-perpustakaan
  static const katalogBukuPerpustakaan = "/katalog-buku-perpustakaan";

  /// /katalog-buku-perpustakaan/{id}
  static String katalogBukuPerpustakaanGetOne(String id) => "/katalog-buku-perpustakaan/$id";

  /// /wishlist
  static const wishlist = "/wishlist";

  /// /wishlist/{id}
  static String oneWishlist(String id) => "/wishlist/$id";

  /// /koleksi
  static const koleksi = "/koleksi";

  /// /koleksi/check/{id}
  static koleksiCheck(String id) => "/koleksi/check/$id";

  /// /faq
  static const faq = "/faq";

  /// /voucher/redeem/{kode}
  static String redeemVoucher(String voucher) => "/voucher/redeem/$voucher";

  /// /list-get-voucher
  static String listGetVoucherAll = "/list-get-voucher";
}

var a = {
  "name": "buku-perpustakaan.getAll | Get All Koleksi Book (with pagination)",
  "type": "Success",
  "statusCode": 200,
  "result": {
    "totalAllData": 10,
    "totalData": 10,
    "limit": 10,
    "totalPage": 1,
    "currentPage": 1,
    "lastPage": 1,
    "nextPage": null,
    "previousPage": null,
    "payload": [
      {
        "id": "eab7545f-9aae-4beb-9cf6-407e41ac1a11",
        "createdAt": "2024-03-25T08:07:15.834Z",
        "updatedAt": "2024-03-25T08:07:15.834Z",
        "buku": {
          "judul": "Panduan Pendampingan Sub Sektor Kriya",
          "sinopsis":
              "Kegiatan pendampingan harus memiliki struktur yang jelas dan memiliki Indikator Kinerja Utama (IKU) atau Key Performance Indicator (KPI) yang terukur. Struktur dan IKU pendampingan wajib diinformasikan kepada pendamping. Sebagian maupun seluruh poin IKU kemudian disepakati oleh pendamping, dan ditanggapi dalam bentuk gagasan, materi, jenis dan platform pendampingan yang didiskusikan oleh pendamping dan penyelenggara. Keterlibatan perwakilan atau calon penerima pendampingan kadang diperlukan untuk memastikan bahwa program pendampingan\r\nsesuai dengan kebutuhan calon penerima pendampingan.\r\n\r\nBuku ini menyajikan praktik baik pendampingan dalam berbagai contoh kasus/studi yang telah dilaksanakan oleh Kementerian, Lembaga maupun organisasi swasta. ",
          "jumlahHalaman": 125,
          "tahunTerbit": "2021",
          "isbn": "9786232560741",
          "eIsbn": "9786232560741",
          "ilustrator": "Aldy Riyadhy, Rian Tanjung, Hayuning Sumbadra",
          "penulis": "Romi Astuti, Benedictus Permadi, Diah Isna N",
          "hargaBeli": 0,
          "hargaSewa": 0,
          "assetSampulId": "46120727-81f7-4264-8aa1-8ce288009ae0",
          "namaPenerbitReal": null,
          "bahasa": {
            "id": "77178ac1-ab7b-476e-aadc-74ecf6159043",
            "bahasaResmi": "Bahasa Indonesia",
            "negara": "Indonesia",
            "deletedAt": null
          },
          "penerbit": {
            "id": "5cec53c8-cc60-40f0-8f4d-22b2d5315ec2",
            "createdAt": "2024-03-25T06:30:57.608Z",
            "updatedAt": "2024-03-25T06:30:57.608Z",
            "nama": "Direktorat Sekolah Menengah Atas Kemendikbudristek",
            "kode": "DSMAK",
            "noTelepon": "0217667960",
            "deskripsi": null,
            "email": "direktorat.sma@kemdikbud.go.id",
            "namaPIC": "Direktorat SMA",
            "contactPersonPIC": "0217667960",
            "tahunBerdiri": "2000"
          },
          "promo": null,
          "id": "4e8db797-5808-4269-a051-91121014ad0d",
          "createdAt": "2024-03-25T07:58:40.666Z",
          "updatedAt": "2024-03-26T03:05:38.787Z",
          "assetBukuId": "fe97c64d-be2d-4b2d-b2ca-f1db3ecd9b6b"
        },
        "jumlahSoftCopy": 1,
        "jumlahSiapPinjam": 1,
        "bukuId": "4e8db797-5808-4269-a051-91121014ad0d",
        "isPin": false,
        "isVisible": true,
        "katalogBukuPerpustakaan": null
      },
      {
        "id": "99bfde13-2544-4c00-8010-a23dd0f3e44a",
        "createdAt": "2024-03-25T08:07:15.835Z",
        "updatedAt": "2024-03-25T08:12:55.810Z",
        "buku": {
          "judul": "Kerja Sama Multilateral Indonesia di Sektor Keuangan",
          "sinopsis":
              "Untuk menindaklanjuti upaya reformasi sistem keuangan menuju stabilitas sistem keuangan, peningkatan peran Indonesia dalam kerja sama internasional secara bilateral, regional, dan multilateral akan menjadi faktor strategis guna mengembangkan kebijakan kerja sama keuangan internasional yang bermanfaat tidak hanya secara khusus bagi Indonesia, namun juga sebagai salah satu bentuk kontribusi Indonesia terhadap perekonomian global. Salah satu inisiatif penting Indonesia untuk melaksanakan tanggung jawab dalam melaksanakan politik luar negeri adalah melalui peningkatan kerja sama dengan berbagai mitra multilateral dan regional di berbagai sektor.\r\n\r\nBuku ini menyajikan berbagai rekomendasi yang disampaikan dalam berbagai artikel tentang kerja sama internasional Indonesia di sektor keuangan. Hal yang perlu diketahui sebagai dasar bagi implementasi kebijakan adalah permasalahan terkait governance dan para pemangku kepentingan dalam isu-isu perubahan iklim serta dampak bagi Indonesia.",
          "jumlahHalaman": 118,
          "tahunTerbit": "2019",
          "isbn": "9786232560741",
          "eIsbn": "9786232560741",
          "ilustrator": "Alfyandi",
          "penulis": "Dr. Adi Budiarso, FCPA (Aus).",
          "hargaBeli": 0,
          "hargaSewa": 0,
          "assetSampulId": "f7bccc01-8774-4b32-a59f-b36bdc1ba710",
          "namaPenerbitReal": null,
          "bahasa": {
            "id": "77178ac1-ab7b-476e-aadc-74ecf6159043",
            "bahasaResmi": "Bahasa Indonesia",
            "negara": "Indonesia",
            "deletedAt": null
          },
          "penerbit": {
            "id": "5cec53c8-cc60-40f0-8f4d-22b2d5315ec2",
            "createdAt": "2024-03-25T06:30:57.608Z",
            "updatedAt": "2024-03-25T06:30:57.608Z",
            "nama": "Direktorat Sekolah Menengah Atas Kemendikbudristek",
            "kode": "DSMAK",
            "noTelepon": "0217667960",
            "deskripsi": null,
            "email": "direktorat.sma@kemdikbud.go.id",
            "namaPIC": "Direktorat SMA",
            "contactPersonPIC": "0217667960",
            "tahunBerdiri": "2000"
          },
          "promo": null,
          "id": "60684ded-3018-408d-acfd-6041cb0df05b",
          "createdAt": "2024-03-25T07:58:40.670Z",
          "updatedAt": "2024-03-26T03:03:03.624Z",
          "assetBukuId": "50168851-9a44-4f01-a538-8643c1d65e92"
        },
        "jumlahSoftCopy": 1,
        "jumlahSiapPinjam": 0,
        "bukuId": "60684ded-3018-408d-acfd-6041cb0df05b",
        "isPin": false,
        "isVisible": true,
        "katalogBukuPerpustakaan": null
      },
    ]
  }
};
