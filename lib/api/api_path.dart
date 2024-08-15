class APIPath {
  // static const base = "https://api.orbitdigilib.com";
  static const base = "https://api-dev.orbitdigilib.com"; // base API for dev

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

  /// /laporan-literasi/durasi-membaca
  static String laporanLiterasi = "/laporan-literasi/durasi-membaca";
}
