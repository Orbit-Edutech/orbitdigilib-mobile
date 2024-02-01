import 'dart:convert';

class AuthForgot {
  final User? user;

  AuthForgot({
    this.user,
  });

  AuthForgot copyWith({
    User? user,
  }) =>
      AuthForgot(
        user: user ?? this.user,
      );

  factory AuthForgot.fromRawJson(String str) => AuthForgot.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthForgot.fromJson(Map<String, dynamic> json) => AuthForgot(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}

class User {
  final String? id;
  final String? username;
  final DateTime? passwordUpdatedAt;
  final String? email;
  final String? nama;
  final String? jenisKelamin;
  final dynamic urlFotoProfil;
  final String? tokenForgotPassword;
  final DateTime? tokenForgotPasswordExpiredAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.username,
    this.passwordUpdatedAt,
    this.email,
    this.nama,
    this.jenisKelamin,
    this.urlFotoProfil,
    this.tokenForgotPassword,
    this.tokenForgotPasswordExpiredAt,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    String? id,
    String? username,
    DateTime? passwordUpdatedAt,
    String? email,
    String? nama,
    String? jenisKelamin,
    dynamic urlFotoProfil,
    String? tokenForgotPassword,
    DateTime? tokenForgotPasswordExpiredAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        passwordUpdatedAt: passwordUpdatedAt ?? this.passwordUpdatedAt,
        email: email ?? this.email,
        nama: nama ?? this.nama,
        jenisKelamin: jenisKelamin ?? this.jenisKelamin,
        urlFotoProfil: urlFotoProfil ?? this.urlFotoProfil,
        tokenForgotPassword: tokenForgotPassword ?? this.tokenForgotPassword,
        tokenForgotPasswordExpiredAt: tokenForgotPasswordExpiredAt ?? this.tokenForgotPasswordExpiredAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        passwordUpdatedAt: json["passwordUpdatedAt"] == null ? null : DateTime.parse(json["passwordUpdatedAt"]),
        email: json["email"],
        nama: json["nama"],
        jenisKelamin: json["jenisKelamin"],
        urlFotoProfil: json["urlFotoProfil"],
        tokenForgotPassword: json["tokenForgotPassword"],
        tokenForgotPasswordExpiredAt:
            json["tokenForgotPasswordExpiredAt"] == null ? null : DateTime.parse(json["tokenForgotPasswordExpiredAt"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "passwordUpdatedAt": passwordUpdatedAt?.toIso8601String(),
        "email": email,
        "nama": nama,
        "jenisKelamin": jenisKelamin,
        "urlFotoProfil": urlFotoProfil,
        "tokenForgotPassword": tokenForgotPassword,
        "tokenForgotPasswordExpiredAt": tokenForgotPasswordExpiredAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
