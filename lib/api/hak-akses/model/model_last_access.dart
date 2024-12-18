import 'dart:convert';

class ModelLastAccess {
  final String? id;
  final User? user;
  final String? perpustakaanId;

  ModelLastAccess({
    this.id,
    this.user,
    this.perpustakaanId,
  });

  factory ModelLastAccess.fromRawJson(String str) => ModelLastAccess.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelLastAccess.fromJson(Map<String, dynamic> json) => ModelLastAccess(
        id: json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        perpustakaanId: json["perpustakaanId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "perpustakaanId": perpustakaanId,
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
