class APIPath {
  static const base = "http://192.168.0.43:4001";

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

  /// /pinjam
  static const pinjam = "/pinjam";

  /// /sewa
  static const sewa = "/sewa";

  /// /kategori-buku-perpustakaan
  static const kategoriBukuPerpustakaan = "/kategori-buku-perpustakaan";

  /// /kategori-buku-perpustakaan/{id}
  static String kategoriBukuPerpustakaanGetOne(String id) => "/kategori-buku-perpustakaan/$id";

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
}
