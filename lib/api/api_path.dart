class APIPath {
  static const base = "https://api.orbitdigilib.com";
  // static const base = "https://api-dev.orbitdigilib.com"; // base API for dev

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

  /// /perpustakaan/by-id/{id}
  static String perpustakaanGetOneById(String id) => "$perpustakaan/$id";

  /// /buku-perpustakaan
  static String allBukuPerpus(String perpustakaanId) => "/buku-perpustakaan/$perpustakaanId";

  /// /buku-perpustakaan/{perpustakaanId}/{id}
  static oneBukuPerpus(String id) => "/buku-perpustakaan/$id";

  /// /buku/{id}
  static oneBuku(String id) => "/buku/$id";

  /// /buku-anggota/{id}
  static oneBukuAnggota(String id) => "/buku-anggota/$id";

  /// /perpustakaan/default/banner
  static const bannerDefault = "/perpustakaan/default/banner";

  /// /pinjam
  static const pinjam = "/pinjam";

  /// /sewa
  static const sewa = "/sewa";

  /// /beli
  static const beli = "/beli";

  /// /katalog-buku-perpustakaan
  static String katalogBukuPerpustakaan(String perpustakaanId) => "/katalog-buku-perpustakaan/$perpustakaanId";

  /// /katalog-buku-perpustakaan/{id}
  static String katalogBukuPerpustakaanGetOne(String id) => "/katalog-buku-perpustakaan/$id";

  /// /wishlist/{perpustakaanId}
  static String wishlist([String? perpustakaanId]) => "/wishlist${perpustakaanId != null ? '/$perpustakaanId' : ''}";

  /// /wishlist/{id}
  static String oneWishlist(String id) => "/wishlist/$id";

  /// /koleksi/{perpustakaanId}
  static String koleksi(String perpustakaanId) => "/koleksi/$perpustakaanId";

  /// /koleksi/check/{id}
  static koleksiCheck(String id) => "/koleksi/check/$id";

  /// /faq
  static const faq = "/faq";

  /// /voucher/redeem/{kode}
  static String redeemVoucher(String voucher) => "/voucher/redeem/$voucher";

  /// /list-get-voucher
  static String listGetVoucherAll = "/list-get-voucher";

  /// /laporan-literasi/durasi-membaca
  static String laporanLiterasi = "/laporan-literasi/durasi-membaca";

  /// /poin-membaca/cek-status/{bukuId}
  static String statusPoinMembaca(String id) => "/poin-membaca/cek-status/$id";

  /// /poin-membaca/resensi/{bukuId}
  static String resensiPoinMembaca(String id) => "/poin-membaca/resensi/$id";

  /// /hak-akses
  static const hakAkses = "/hak-akses";

  /// /all-access
  static const allAccess = "$hakAkses/all-access";

  /// /last-access
  static const lastAccess = "$hakAkses/last-access";

  /// /check-access
  static String checkAccess(String perpustakaanId) => "$hakAkses/check-access-right/$perpustakaanId";

  /// /change-access
  static String changeAccess(String perpustakaanId) => "$hakAkses/change-access/$perpustakaanId";

  /// /set-default-access-right
  static const setDefaultAccessRight = "$hakAkses/set-default-access-right";
}
