import 'dart:convert';

class ModelSewa {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? hargaSewa;
  final DateTime? tanggalSewa;
  final DateTime? tanggalHabisSewa;
  final User? user;
  final Buku? buku;

  ModelSewa({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.hargaSewa,
    this.tanggalSewa,
    this.tanggalHabisSewa,
    this.user,
    this.buku,
  });

  ModelSewa copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hargaSewa,
    DateTime? tanggalSewa,
    DateTime? tanggalHabisSewa,
    User? user,
    Buku? buku,
  }) =>
      ModelSewa(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        hargaSewa: hargaSewa ?? this.hargaSewa,
        tanggalSewa: tanggalSewa ?? this.tanggalSewa,
        tanggalHabisSewa: tanggalHabisSewa ?? this.tanggalHabisSewa,
        user: user ?? this.user,
        buku: buku ?? this.buku,
      );

  factory ModelSewa.fromRawJson(String str) => ModelSewa.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelSewa.fromJson(Map<String, dynamic> json) => ModelSewa(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        hargaSewa: json["hargaSewa"],
        tanggalSewa: json["tanggalSewa"] == null ? null : DateTime.parse(json["tanggalSewa"]),
        tanggalHabisSewa: json["tanggalHabisSewa"] == null ? null : DateTime.parse(json["tanggalHabisSewa"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        buku: json["buku"] == null ? null : Buku.fromJson(json["buku"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "hargaSewa": hargaSewa,
        "tanggalSewa": tanggalSewa?.toIso8601String(),
        "tanggalHabisSewa": tanggalHabisSewa?.toIso8601String(),
        "user": user?.toJson(),
        "buku": buku?.toJson(),
      };
}

class Buku {
  final String? id;
  final String? judul;
  final int? jumlahHalaman;
  final String? tahunTerbit;
  final String? penulis;
  final int? hargaBeli;
  final int? hargaSewa;
  final String? assetSampulId;

  Buku({
    this.id,
    this.judul,
    this.jumlahHalaman,
    this.tahunTerbit,
    this.penulis,
    this.hargaBeli,
    this.hargaSewa,
    this.assetSampulId,
  });

  Buku copyWith({
    String? id,
    String? judul,
    int? jumlahHalaman,
    String? tahunTerbit,
    String? penulis,
    int? hargaBeli,
    int? hargaSewa,
    String? assetSampulId,
  }) =>
      Buku(
        id: id ?? this.id,
        judul: judul ?? this.judul,
        jumlahHalaman: jumlahHalaman ?? this.jumlahHalaman,
        tahunTerbit: tahunTerbit ?? this.tahunTerbit,
        penulis: penulis ?? this.penulis,
        hargaBeli: hargaBeli ?? this.hargaBeli,
        hargaSewa: hargaSewa ?? this.hargaSewa,
        assetSampulId: assetSampulId ?? this.assetSampulId,
      );

  factory Buku.fromRawJson(String str) => Buku.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Buku.fromJson(Map<String, dynamic> json) => Buku(
        id: json["id"],
        judul: json["judul"],
        jumlahHalaman: json["jumlahHalaman"],
        tahunTerbit: json["tahunTerbit"],
        penulis: json["penulis"],
        hargaBeli: json["hargaBeli"],
        hargaSewa: json["hargaSewa"],
        assetSampulId: json["assetSampulId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "jumlahHalaman": jumlahHalaman,
        "tahunTerbit": tahunTerbit,
        "penulis": penulis,
        "hargaBeli": hargaBeli,
        "hargaSewa": hargaSewa,
        "assetSampulId": assetSampulId,
      };
}

class User {
  final String? id;
  final String? username;
  final dynamic passwordUpdatedAt;
  final String? email;
  final String? nama;
  final String? jenisKelamin;
  final dynamic noTelepon;
  final dynamic urlFotoProfil;
  final dynamic tokenForgotPassword;
  final dynamic tokenForgotPasswordExpiredAt;
  final String? token;
  final Role? role;

  User({
    this.id,
    this.username,
    this.passwordUpdatedAt,
    this.email,
    this.nama,
    this.jenisKelamin,
    this.noTelepon,
    this.urlFotoProfil,
    this.tokenForgotPassword,
    this.tokenForgotPasswordExpiredAt,
    this.token,
    this.role,
  });

  User copyWith({
    String? id,
    String? username,
    dynamic passwordUpdatedAt,
    String? email,
    String? nama,
    String? jenisKelamin,
    dynamic noTelepon,
    dynamic urlFotoProfil,
    dynamic tokenForgotPassword,
    dynamic tokenForgotPasswordExpiredAt,
    String? token,
    Role? role,
  }) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        passwordUpdatedAt: passwordUpdatedAt ?? this.passwordUpdatedAt,
        email: email ?? this.email,
        nama: nama ?? this.nama,
        jenisKelamin: jenisKelamin ?? this.jenisKelamin,
        noTelepon: noTelepon ?? this.noTelepon,
        urlFotoProfil: urlFotoProfil ?? this.urlFotoProfil,
        tokenForgotPassword: tokenForgotPassword ?? this.tokenForgotPassword,
        tokenForgotPasswordExpiredAt: tokenForgotPasswordExpiredAt ?? this.tokenForgotPasswordExpiredAt,
        token: token ?? this.token,
        role: role ?? this.role,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        passwordUpdatedAt: json["passwordUpdatedAt"],
        email: json["email"],
        nama: json["nama"],
        jenisKelamin: json["jenisKelamin"],
        noTelepon: json["noTelepon"],
        urlFotoProfil: json["urlFotoProfil"],
        tokenForgotPassword: json["tokenForgotPassword"],
        tokenForgotPasswordExpiredAt: json["tokenForgotPasswordExpiredAt"],
        token: json["token"],
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "passwordUpdatedAt": passwordUpdatedAt,
        "email": email,
        "nama": nama,
        "jenisKelamin": jenisKelamin,
        "noTelepon": noTelepon,
        "urlFotoProfil": urlFotoProfil,
        "tokenForgotPassword": tokenForgotPassword,
        "tokenForgotPasswordExpiredAt": tokenForgotPasswordExpiredAt,
        "token": token,
        "role": role?.toJson(),
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
