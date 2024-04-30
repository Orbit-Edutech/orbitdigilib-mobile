import 'dart:convert';

class AuthValidate {
  final User? user;
  final Versions? version;

  AuthValidate({
    this.user,
    this.version,
  });

  AuthValidate copyWith({
    User? user,
    Versions? version,
  }) =>
      AuthValidate(
        user: user ?? this.user,
        version: version ?? this.version,
      );

  factory AuthValidate.fromRawJson(String str) => AuthValidate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthValidate.fromJson(Map<String, dynamic> json) => AuthValidate(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        version: json["version"] == null ? null : Versions.fromJson(json["version"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "version": version?.toJson(),
      };
}

class User {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? username;
  final DateTime? passwordUpdatedAt;
  final String? email;
  final String? nama;
  final String? jenisKelamin;
  final String? noTelepon;
  final dynamic urlFotoProfil;
  final String? tokenForgotPassword;
  final DateTime? tokenForgotPasswordExpiredAt;
  final String? token;
  final Role? role;
  final Perpustakaan? perpustakaan;
  final dynamic penerbit;
  final bool? isAktif;

  User({
    this.id,
    this.createdAt,
    this.updatedAt,
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
    this.perpustakaan,
    this.penerbit,
    this.isAktif,
  });

  User copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? username,
    DateTime? passwordUpdatedAt,
    String? email,
    String? nama,
    String? jenisKelamin,
    String? noTelepon,
    dynamic urlFotoProfil,
    String? tokenForgotPassword,
    DateTime? tokenForgotPasswordExpiredAt,
    String? token,
    Role? role,
    Perpustakaan? perpustakaan,
    dynamic penerbit,
    bool? isAktif,
  }) =>
      User(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
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
        perpustakaan: perpustakaan ?? this.perpustakaan,
        penerbit: penerbit ?? this.penerbit,
        isAktif: isAktif ?? this.isAktif,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
        perpustakaan: json["perpustakaan"] == null ? null : Perpustakaan.fromJson(json["perpustakaan"]),
        penerbit: json["penerbit"],
        isAktif: json["isAktif"],
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
        "noTelepon": noTelepon,
        "urlFotoProfil": urlFotoProfil,
        "tokenForgotPassword": tokenForgotPassword,
        "tokenForgotPasswordExpiredAt": tokenForgotPasswordExpiredAt?.toIso8601String(),
        "token": token,
        "role": role?.toJson(),
        "perpustakaan": perpustakaan?.toJson(),
        "penerbit": penerbit,
        "isAktif": isAktif,
      };
}

class Perpustakaan {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? nama;
  final String? kode;
  final String? noTelepon;
  final dynamic deskripsi;
  final String? tahunBerdiri;
  final String? warnaDasar;
  final String? email;
  final String? namaPic;
  final String? contactPersonPic;
  final String? nomorIndukSekolah;
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
    this.email,
    this.namaPic,
    this.contactPersonPic,
    this.nomorIndukSekolah,
    this.isAktif,
  });

  Perpustakaan copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? nama,
    String? kode,
    String? noTelepon,
    dynamic deskripsi,
    String? tahunBerdiri,
    String? warnaDasar,
    String? email,
    String? namaPic,
    String? contactPersonPic,
    String? nomorIndukSekolah,
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
        email: email ?? this.email,
        namaPic: namaPic ?? this.namaPic,
        contactPersonPic: contactPersonPic ?? this.contactPersonPic,
        nomorIndukSekolah: nomorIndukSekolah ?? this.nomorIndukSekolah,
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
        email: json["email"],
        namaPic: json["namaPIC"],
        contactPersonPic: json["contactPersonPIC"],
        nomorIndukSekolah: json["nomorIndukSekolah"],
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
        "email": email,
        "namaPIC": namaPic,
        "contactPersonPIC": contactPersonPic,
        "nomorIndukSekolah": nomorIndukSekolah,
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

class Versions {
  final Version? android;
  final Version? iOs;

  Versions({
    this.android,
    this.iOs,
  });

  Versions copyWith({
    Version? android,
    Version? iOs,
  }) =>
      Versions(
        android: android ?? this.android,
        iOs: iOs ?? this.iOs,
      );

  factory Versions.fromRawJson(String str) => Versions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Versions.fromJson(Map<String, dynamic> json) => Versions(
        android: json["android"] == null ? null : Version.fromJson(json["android"]),
        iOs: json["iOS"] == null ? null : Version.fromJson(json["iOS"]),
      );

  Map<String, dynamic> toJson() => {
        "android": android?.toJson(),
        "iOS": iOs?.toJson(),
      };
}

class Version {
  final DateTime? updatedAt;
  final int? versionCode;
  final String? versionName;

  Version({
    this.updatedAt,
    this.versionCode,
    this.versionName,
  });

  Version copyWith({
    DateTime? updatedAt,
    int? versionCode,
    String? versionName,
  }) =>
      Version(
        updatedAt: updatedAt ?? this.updatedAt,
        versionCode: versionCode ?? this.versionCode,
        versionName: versionName ?? this.versionName,
      );

  factory Version.fromRawJson(String str) => Version.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Version.fromJson(Map<String, dynamic> json) => Version(
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        versionCode: json["versionCode"],
        versionName: json["versionName"],
      );

  Map<String, dynamic> toJson() => {
        "updatedAt": updatedAt?.toIso8601String(),
        "versionCode": versionCode,
        "versionName": versionName,
      };
}
