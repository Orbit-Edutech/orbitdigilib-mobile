import 'dart:convert';

class Redeem {
  final String? id;
  final String? username;
  final dynamic passwordUpdatedAt;
  final String? email;
  final String? nama;
  final String? jenisKelamin;
  final dynamic urlFotoProfil;
  final dynamic tokenForgotPassword;
  final dynamic tokenForgotPasswordExpiredAt;
  final int? token;
  final Role? role;

  Redeem({
    this.id,
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
  });

  Redeem copyWith({
    String? id,
    String? username,
    dynamic passwordUpdatedAt,
    String? email,
    String? nama,
    String? jenisKelamin,
    dynamic urlFotoProfil,
    dynamic tokenForgotPassword,
    dynamic tokenForgotPasswordExpiredAt,
    int? token,
    Role? role,
  }) =>
      Redeem(
        id: id ?? this.id,
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
      );

  factory Redeem.fromRawJson(String str) => Redeem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Redeem.fromJson(Map<String, dynamic> json) => Redeem(
        id: json["id"],
        username: json["username"],
        passwordUpdatedAt: json["passwordUpdatedAt"],
        email: json["email"],
        nama: json["nama"],
        jenisKelamin: json["jenisKelamin"],
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
