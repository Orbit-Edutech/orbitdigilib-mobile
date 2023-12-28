class APIPath {
  static const base = "http://192.168.0.43:4001";

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

  /// /auth/refresh
  static const refresh = "$auth/refresh";

  /// /perpustakaan
  static const perpustakaan = "/perpustakaan";

  /// /perpustakaan/{kode}
  static String perpustakaanGetOne(String kode) => "$perpustakaan/$kode";

  /// /buku-perpustakaan
  static const allBuku = "/buku-perpustakaan";
}
