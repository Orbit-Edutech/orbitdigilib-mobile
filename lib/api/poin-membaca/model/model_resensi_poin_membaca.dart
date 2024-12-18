import 'dart:convert';

class ResensiPoinMembaca {
  User? user;
  Buku? buku;
  dynamic resensi;

  ResensiPoinMembaca({
    this.user,
    this.buku,
    this.resensi,
  });

  ResensiPoinMembaca copyWith({
    User? user,
    Buku? buku,
    dynamic resensi,
  }) =>
      ResensiPoinMembaca(
        user: user ?? this.user,
        buku: buku ?? this.buku,
        resensi: resensi ?? this.resensi,
      );

  factory ResensiPoinMembaca.fromRawJson(String str) => ResensiPoinMembaca.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResensiPoinMembaca.fromJson(Map<String, dynamic> json) => ResensiPoinMembaca(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        buku: json["buku"] == null ? null : Buku.fromJson(json["buku"]),
        resensi: json["resensi"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "buku": buku?.toJson(),
        "resensi": resensi,
      };
}

class Buku {
  String? id;
  String? judul;
  int? jumlahHalaman;
  String? tahunTerbit;
  String? penulis;
  int? hargaBeli;
  int? hargaSewa;
  dynamic namaPenerbitReal;
  bool? peringatan;
  dynamic keterangan;
  String? assetSampulId;
  dynamic promo;

  Buku({
    this.id,
    this.judul,
    this.jumlahHalaman,
    this.tahunTerbit,
    this.penulis,
    this.hargaBeli,
    this.hargaSewa,
    this.namaPenerbitReal,
    this.peringatan,
    this.keterangan,
    this.assetSampulId,
    this.promo,
  });

  Buku copyWith({
    String? id,
    String? judul,
    int? jumlahHalaman,
    String? tahunTerbit,
    String? penulis,
    int? hargaBeli,
    int? hargaSewa,
    dynamic namaPenerbitReal,
    bool? peringatan,
    dynamic keterangan,
    String? assetSampulId,
    dynamic promo,
  }) =>
      Buku(
        id: id ?? this.id,
        judul: judul ?? this.judul,
        jumlahHalaman: jumlahHalaman ?? this.jumlahHalaman,
        tahunTerbit: tahunTerbit ?? this.tahunTerbit,
        penulis: penulis ?? this.penulis,
        hargaBeli: hargaBeli ?? this.hargaBeli,
        hargaSewa: hargaSewa ?? this.hargaSewa,
        namaPenerbitReal: namaPenerbitReal ?? this.namaPenerbitReal,
        peringatan: peringatan ?? this.peringatan,
        keterangan: keterangan ?? this.keterangan,
        assetSampulId: assetSampulId ?? this.assetSampulId,
        promo: promo ?? this.promo,
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
        namaPenerbitReal: json["namaPenerbitReal"],
        peringatan: json["peringatan"],
        keterangan: json["keterangan"],
        assetSampulId: json["assetSampulId"],
        promo: json["promo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "jumlahHalaman": jumlahHalaman,
        "tahunTerbit": tahunTerbit,
        "penulis": penulis,
        "hargaBeli": hargaBeli,
        "hargaSewa": hargaSewa,
        "namaPenerbitReal": namaPenerbitReal,
        "peringatan": peringatan,
        "keterangan": keterangan,
        "assetSampulId": assetSampulId,
        "promo": promo,
      };
}

class User {
  String? id;
  String? username;
  DateTime? passwordUpdatedAt;
  String? email;
  String? nama;
  String? jenisKelamin;
  String? noTelepon;
  dynamic urlFotoProfil;
  String? tokenForgotPassword;
  DateTime? tokenForgotPasswordExpiredAt;
  String? token;
  bool? isAktif;

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
    this.isAktif,
  });

  User copyWith({
    String? id,
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
    bool? isAktif,
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
        isAktif: isAktif ?? this.isAktif,
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
        noTelepon: json["noTelepon"],
        urlFotoProfil: json["urlFotoProfil"],
        tokenForgotPassword: json["tokenForgotPassword"],
        tokenForgotPasswordExpiredAt:
            json["tokenForgotPasswordExpiredAt"] == null ? null : DateTime.parse(json["tokenForgotPasswordExpiredAt"]),
        token: json["token"],
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
        "isAktif": isAktif,
      };
}
