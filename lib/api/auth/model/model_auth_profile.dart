import 'dart:convert';

class AuthProfile {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? username;
  final DateTime? passwordUpdatedAt;
  final String? email;
  final String? nama;
  final String? jenisKelamin;
  final dynamic urlFotoProfil;
  final String? tokenForgotPassword;
  final DateTime? tokenForgotPasswordExpiredAt;
  final String? token;
  final Role? role;
  final Perpustakaan? perpustakaan;
  final dynamic penerbit;
  final int? totalBukuFisikDipinjam;
  final String? nomorKeanggotaan;
  final bool? isPending;

  AuthProfile({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.passwordUpdatedAt,
    this.email,
    this.nama,
    this.jenisKelamin,
    this.urlFotoProfil,
    this.tokenForgotPassword,
    this.tokenForgotPasswordExpiredAt,
    this.token,
    this.role,
    this.perpustakaan,
    this.penerbit,
    this.totalBukuFisikDipinjam,
    this.nomorKeanggotaan,
    this.isPending,
  });

  AuthProfile copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? username,
    DateTime? passwordUpdatedAt,
    String? email,
    String? nama,
    String? jenisKelamin,
    dynamic urlFotoProfil,
    String? tokenForgotPassword,
    DateTime? tokenForgotPasswordExpiredAt,
    String? token,
    Role? role,
    Perpustakaan? perpustakaan,
    dynamic penerbit,
    int? totalBukuFisikDipinjam,
    String? nomorKeanggotaan,
    bool? isPending,
  }) =>
      AuthProfile(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        username: username ?? this.username,
        passwordUpdatedAt: passwordUpdatedAt ?? this.passwordUpdatedAt,
        email: email ?? this.email,
        nama: nama ?? this.nama,
        jenisKelamin: jenisKelamin ?? this.jenisKelamin,
        urlFotoProfil: urlFotoProfil ?? this.urlFotoProfil,
        tokenForgotPassword: tokenForgotPassword ?? this.tokenForgotPassword,
        tokenForgotPasswordExpiredAt: tokenForgotPasswordExpiredAt ?? this.tokenForgotPasswordExpiredAt,
        token: token ?? this.token,
        role: role ?? this.role,
        perpustakaan: perpustakaan ?? this.perpustakaan,
        penerbit: penerbit ?? this.penerbit,
        totalBukuFisikDipinjam: totalBukuFisikDipinjam ?? this.totalBukuFisikDipinjam,
        nomorKeanggotaan: nomorKeanggotaan ?? this.nomorKeanggotaan,
        isPending: isPending ?? this.isPending,
      );

  factory AuthProfile.fromRawJson(String str) => AuthProfile.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthProfile.fromJson(Map<String, dynamic> json) => AuthProfile(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        username: json["username"],
        passwordUpdatedAt: json["passwordUpdatedAt"] == null ? null : DateTime.parse(json["passwordUpdatedAt"]),
        email: json["email"],
        nama: json["nama"],
        jenisKelamin: json["jenisKelamin"],
        urlFotoProfil: json["urlFotoProfil"],
        tokenForgotPassword: json["tokenForgotPassword"],
        tokenForgotPasswordExpiredAt:
            json["tokenForgotPasswordExpiredAt"] == null ? null : DateTime.parse(json["tokenForgotPasswordExpiredAt"]),
        token: json["token"],
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
        perpustakaan: json["perpustakaan"] == null ? null : Perpustakaan.fromJson(json["perpustakaan"]),
        penerbit: json["penerbit"],
        totalBukuFisikDipinjam: json["totalBukuFisikDipinjam"],
        nomorKeanggotaan: json["nomorKeanggotaan"],
        isPending: json["isPending"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "username": username,
        "passwordUpdatedAt": passwordUpdatedAt?.toIso8601String(),
        "email": email,
        "nama": nama,
        "jenisKelamin": jenisKelamin,
        "urlFotoProfil": urlFotoProfil,
        "tokenForgotPassword": tokenForgotPassword,
        "tokenForgotPasswordExpiredAt": tokenForgotPasswordExpiredAt?.toIso8601String(),
        "token": token,
        "role": role?.toJson(),
        "perpustakaan": perpustakaan?.toJson(),
        "penerbit": penerbit,
        "totalBukuFisikDipinjam": totalBukuFisikDipinjam,
        "nomorKeanggotaan": nomorKeanggotaan,
        "isPending": isPending,
      };
}

class Perpustakaan {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? nama;
  final String? kode;
  final String? noTelepon;
  final String? deskripsi;
  final dynamic tahunBerdiri;
  final String? warnaDasar;
  final bool? isAktif;

  Perpustakaan({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.nama,
    this.kode,
    this.noTelepon,
    this.deskripsi,
    this.tahunBerdiri,
    this.warnaDasar,
    this.isAktif,
  });

  Perpustakaan copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? nama,
    String? kode,
    String? noTelepon,
    String? deskripsi,
    dynamic tahunBerdiri,
    String? warnaDasar,
    bool? isAktif,
  }) =>
      Perpustakaan(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        nama: nama ?? this.nama,
        kode: kode ?? this.kode,
        noTelepon: noTelepon ?? this.noTelepon,
        deskripsi: deskripsi ?? this.deskripsi,
        tahunBerdiri: tahunBerdiri ?? this.tahunBerdiri,
        warnaDasar: warnaDasar ?? this.warnaDasar,
        isAktif: isAktif ?? this.isAktif,
      );

  factory Perpustakaan.fromRawJson(String str) => Perpustakaan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Perpustakaan.fromJson(Map<String, dynamic> json) => Perpustakaan(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        nama: json["nama"],
        kode: json["kode"],
        noTelepon: json["noTelepon"],
        deskripsi: json["deskripsi"],
        tahunBerdiri: json["tahunBerdiri"],
        warnaDasar: json["warnaDasar"],
        isAktif: json["isAktif"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "nama": nama,
        "kode": kode,
        "noTelepon": noTelepon,
        "deskripsi": deskripsi,
        "tahunBerdiri": tahunBerdiri,
        "warnaDasar": warnaDasar,
        "isAktif": isAktif,
      };
}

class Role {
  final String? nama;

  Role({
    this.nama,
  });

  Role copyWith({
    String? nama,
  }) =>
      Role(
        nama: nama ?? this.nama,
      );

  factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
      };
}
