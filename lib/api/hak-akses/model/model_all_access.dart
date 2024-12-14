import 'dart:convert';

class ModelAllAccess {
  final User? user;
  final List<Access>? listAccess;

  ModelAllAccess({
    this.user,
    this.listAccess,
  });

  factory ModelAllAccess.fromRawJson(String str) => ModelAllAccess.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelAllAccess.fromJson(Map<String, dynamic> json) => ModelAllAccess(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        listAccess: json["listAccess"] == null
            ? []
            : List<Access>.from(json["listAccess"]!.map(
                (x) => Access.fromJson(x),
              )),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "listAccess": listAccess == null ? [] : List<dynamic>.from(listAccess!.map((x) => x.toJson())),
      };
}

class Access {
  final String? id;
  final Perpustakaan? perpustakaan;
  final bool? hakAkses;

  Access({
    this.id,
    this.perpustakaan,
    this.hakAkses,
  });

  factory Access.fromRawJson(String str) => Access.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Access.fromJson(Map<String, dynamic> json) => Access(
        id: json["id"],
        perpustakaan: json["perpustakaan"] == null ? null : Perpustakaan.fromJson(json["perpustakaan"]),
        hakAkses: json["hakAkses"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "perpustakaan": perpustakaan?.toJson(),
        "hakAkses": hakAkses,
      };
}

class Perpustakaan {
  final String? id;
  final String? kode;
  final String? nama;
  final String? deskripsi;
  final String? noTelepon;
  final String? email;
  final String? tahunBerdiri;
  final String? warnaDasar;
  final String? npsn;

  Perpustakaan({
    this.id,
    this.kode,
    this.nama,
    this.deskripsi,
    this.noTelepon,
    this.email,
    this.tahunBerdiri,
    this.warnaDasar,
    this.npsn,
  });

  factory Perpustakaan.fromRawJson(String str) => Perpustakaan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Perpustakaan.fromJson(Map<String, dynamic> json) => Perpustakaan(
        id: json["id"],
        kode: json["kode"],
        nama: json["nama"],
        deskripsi: json["deskripsi"],
        noTelepon: json["noTelepon"],
        email: json["email"],
        tahunBerdiri: json["tahunBerdiri"],
        warnaDasar: json["warnaDasar"],
        npsn: json["NPSN"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nama": nama,
        "deskripsi": deskripsi,
        "noTelepon": noTelepon,
        "email": email,
        "tahunBerdiri": tahunBerdiri,
        "warnaDasar": warnaDasar,
        "NPSN": npsn,
      };
}

class User {
  final String? id;
  final String? username;
  final DateTime? passwordUpdatedAt;
  final String? email;
  final String? nama;
  final String? jenisKelamin;
  final String? noTelepon;
  final String? urlFotoProfil;
  final String? tokenForgotPassword;
  final DateTime? tokenForgotPasswordExpiredAt;
  final dynamic token;
  final Role? role;
  final Profil? profil;
  final bool? isAktif;

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
    this.profil,
    this.isAktif,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        passwordUpdatedAt: json["passwordUpdatedAt"] == null ? null : DateTime.parse(json["passwordUpdatedAt"]),
        email: json["email"],
        nama: json["nama"],
        jenisKelamin: json["jenisKelamin"],
        noTelepon: json["noTelepon"],
        urlFotoProfil: json["urlFotoProfil"],
        tokenForgotPassword: json["tokenForgotPassword"],
        tokenForgotPasswordExpiredAt:
            json["tokenForgotPasswordExpiredAt"] == null ? null : DateTime.parse(json["tokenForgotPasswordExpiredAt"]),
        token: json["token"],
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
        profil: json["profil"] == null ? null : Profil.fromJson(json["profil"]),
        isAktif: json["isAktif"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "passwordUpdatedAt": passwordUpdatedAt?.toIso8601String(),
        "email": email,
        "nama": nama,
        "jenisKelamin": jenisKelamin,
        "noTelepon": noTelepon,
        "urlFotoProfil": urlFotoProfil,
        "tokenForgotPassword": tokenForgotPassword,
        "tokenForgotPasswordExpiredAt": tokenForgotPasswordExpiredAt?.toIso8601String(),
        "token": token,
        "role": role?.toJson(),
        "profil": profil?.toJson(),
        "isAktif": isAktif,
      };
}

class Profil {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Profil({
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory Profil.fromRawJson(String str) => Profil.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Profil.fromJson(Map<String, dynamic> json) => Profil(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}

class Role {
  Role();

  factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Role.fromJson(Map<String, dynamic> json) => Role();

  Map<String, dynamic> toJson() => {};
}
