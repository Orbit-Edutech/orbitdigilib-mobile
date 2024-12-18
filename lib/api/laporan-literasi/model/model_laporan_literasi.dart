import 'dart:convert';

class ModelLaporanLiterasi {
  String? id;
  User? user;
  Buku? buku;
  List<DurasiHalaman>? durasiHalaman;

  ModelLaporanLiterasi({
    this.id,
    this.user,
    this.buku,
    this.durasiHalaman,
  });

  ModelLaporanLiterasi copyWith({
    String? id,
    User? user,
    Buku? buku,
    List<DurasiHalaman>? durasiHalaman,
  }) =>
      ModelLaporanLiterasi(
        id: id ?? this.id,
        user: user ?? this.user,
        buku: buku ?? this.buku,
        durasiHalaman: durasiHalaman ?? this.durasiHalaman,
      );

  factory ModelLaporanLiterasi.fromRawJson(String str) => ModelLaporanLiterasi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelLaporanLiterasi.fromJson(Map<String, dynamic> json) => ModelLaporanLiterasi(
        id: json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        buku: json["buku"] == null ? null : Buku.fromJson(json["buku"]),
        durasiHalaman: json["durasiHalaman"] == null
            ? []
            : List<DurasiHalaman>.from(json["durasiHalaman"]!.map((x) => DurasiHalaman.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "buku": buku?.toJson(),
        "durasiHalaman": durasiHalaman == null ? [] : List<dynamic>.from(durasiHalaman!.map((x) => x.toJson())),
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
  String? namaPenerbitReal;
  bool? peringatan;
  dynamic keterangan;
  String? assetSampulId;
  Promo? promo;

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
    String? namaPenerbitReal,
    bool? peringatan,
    dynamic keterangan,
    String? assetSampulId,
    Promo? promo,
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
        promo: json["promo"] == null ? null : Promo.fromJson(json["promo"]),
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
        "promo": promo?.toJson(),
      };
}

class Promo {
  String? id;
  DateTime? mulaiPromo;
  DateTime? batasPromo;
  String? tipe;
  int? jumlah;

  Promo({
    this.id,
    this.mulaiPromo,
    this.batasPromo,
    this.tipe,
    this.jumlah,
  });

  Promo copyWith({
    String? id,
    DateTime? mulaiPromo,
    DateTime? batasPromo,
    String? tipe,
    int? jumlah,
  }) =>
      Promo(
        id: id ?? this.id,
        mulaiPromo: mulaiPromo ?? this.mulaiPromo,
        batasPromo: batasPromo ?? this.batasPromo,
        tipe: tipe ?? this.tipe,
        jumlah: jumlah ?? this.jumlah,
      );

  factory Promo.fromRawJson(String str) => Promo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(
        id: json["id"],
        mulaiPromo: json["mulaiPromo"] == null ? null : DateTime.parse(json["mulaiPromo"]),
        batasPromo: json["batasPromo"] == null ? null : DateTime.parse(json["batasPromo"]),
        tipe: json["tipe"],
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mulaiPromo": mulaiPromo?.toIso8601String(),
        "batasPromo": batasPromo?.toIso8601String(),
        "tipe": tipe,
        "jumlah": jumlah,
      };
}

class DurasiHalaman {
  int? halaman;
  int? durasi;

  DurasiHalaman({
    this.halaman,
    this.durasi,
  });

  DurasiHalaman copyWith({
    int? halaman,
    int? durasi,
  }) =>
      DurasiHalaman(
        halaman: halaman ?? this.halaman,
        durasi: durasi ?? this.durasi,
      );

  factory DurasiHalaman.fromRawJson(String str) => DurasiHalaman.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DurasiHalaman.fromJson(Map<String, dynamic> json) => DurasiHalaman(
        halaman: json["halaman"],
        durasi: json["durasi"],
      );

  Map<String, dynamic> toJson() => {
        "halaman": halaman,
        "durasi": durasi,
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
