import 'dart:convert';

class AuthRegister {
  final User? user;

  AuthRegister({
    this.user,
  });

  AuthRegister copyWith({
    User? user,
  }) =>
      AuthRegister(
        user: user ?? this.user,
      );

  factory AuthRegister.fromRawJson(String str) => AuthRegister.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthRegister.fromJson(Map<String, dynamic> json) => AuthRegister(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}

class User {
  final String? id;
  final String? username;
  final String? email;
  final String? nama;
  final String? jenisKelamin;
  final String? noTelepon;
  final bool? isAktif;
  final String? roleId;
  final String? perpustakaanId;
  final int? poin;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.username,
    this.email,
    this.nama,
    this.jenisKelamin,
    this.noTelepon,
    this.isAktif,
    this.roleId,
    this.perpustakaanId,
    this.poin,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? nama,
    String? jenisKelamin,
    String? noTelepon,
    bool? isAktif,
    String? roleId,
    String? perpustakaanId,
    int? poin,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        nama: nama ?? this.nama,
        jenisKelamin: jenisKelamin ?? this.jenisKelamin,
        noTelepon: noTelepon ?? this.noTelepon,
        isAktif: isAktif ?? this.isAktif,
        roleId: roleId ?? this.roleId,
        perpustakaanId: perpustakaanId ?? this.perpustakaanId,
        poin: poin ?? this.poin,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        nama: json["nama"],
        jenisKelamin: json["jenisKelamin"],
        noTelepon: json["noTelepon"],
        isAktif: json["isAktif"],
        roleId: json["roleId"],
        perpustakaanId: json["perpustakaanId"],
        poin: json["poin"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "nama": nama,
        "jenisKelamin": jenisKelamin,
        "noTelepon": noTelepon,
        "isAktif": isAktif,
        "roleId": roleId,
        "perpustakaanId": perpustakaanId,
        "poin": poin,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
