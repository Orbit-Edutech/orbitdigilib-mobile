import 'dart:convert';

class ModelBeli {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? hargaBeli;
  final User? user;
  final Buku? buku;

  ModelBeli({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.hargaBeli,
    this.user,
    this.buku,
  });

  ModelBeli copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hargaBeli,
    User? user,
    Buku? buku,
  }) =>
      ModelBeli(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        hargaBeli: hargaBeli ?? this.hargaBeli,
        user: user ?? this.user,
        buku: buku ?? this.buku,
      );

  factory ModelBeli.fromRawJson(String str) => ModelBeli.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelBeli.fromJson(Map<String, dynamic> json) => ModelBeli(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        hargaBeli: json["hargaBeli"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        buku: json["buku"] == null ? null : Buku.fromJson(json["buku"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "hargaBeli": hargaBeli,
        "user": user?.toJson(),
        "buku": buku?.toJson(),
      };
}

class Buku {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? judul;
  final String? sinopsis;
  final int? jumlahHalaman;
  final String? tahunTerbit;
  final String? isbn;
  final String? eIsbn;
  final String? eIssn;
  final String? ilustrator;
  final String? penulis;
  final int? hargaBeli;
  final int? hargaSewa;
  final String? assetSampulId;
  final String? namaPenerbitReal;
  final bool? peringatan;
  final String? keterangan;
  final Promo? promo;

  Buku({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.judul,
    this.sinopsis,
    this.jumlahHalaman,
    this.tahunTerbit,
    this.isbn,
    this.eIsbn,
    this.eIssn,
    this.ilustrator,
    this.penulis,
    this.hargaBeli,
    this.hargaSewa,
    this.assetSampulId,
    this.namaPenerbitReal,
    this.peringatan,
    this.keterangan,
    this.promo,
  });

  Buku copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? judul,
    String? sinopsis,
    int? jumlahHalaman,
    String? tahunTerbit,
    String? isbn,
    String? eIsbn,
    String? eIssn,
    String? ilustrator,
    String? penulis,
    int? hargaBeli,
    int? hargaSewa,
    String? assetSampulId,
    String? namaPenerbitReal,
    bool? peringatan,
    String? keterangan,
    Promo? promo,
  }) =>
      Buku(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        judul: judul ?? this.judul,
        sinopsis: sinopsis ?? this.sinopsis,
        jumlahHalaman: jumlahHalaman ?? this.jumlahHalaman,
        tahunTerbit: tahunTerbit ?? this.tahunTerbit,
        isbn: isbn ?? this.isbn,
        eIsbn: eIsbn ?? this.eIsbn,
        eIssn: eIssn ?? this.eIssn,
        ilustrator: ilustrator ?? this.ilustrator,
        penulis: penulis ?? this.penulis,
        hargaBeli: hargaBeli ?? this.hargaBeli,
        hargaSewa: hargaSewa ?? this.hargaSewa,
        assetSampulId: assetSampulId ?? this.assetSampulId,
        namaPenerbitReal: namaPenerbitReal ?? this.namaPenerbitReal,
        peringatan: peringatan ?? this.peringatan,
        keterangan: keterangan ?? this.keterangan,
        promo: promo ?? this.promo,
      );

  factory Buku.fromRawJson(String str) => Buku.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Buku.fromJson(Map<String, dynamic> json) => Buku(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        judul: json["judul"],
        sinopsis: json["sinopsis"],
        jumlahHalaman: json["jumlahHalaman"],
        tahunTerbit: json["tahunTerbit"],
        isbn: json["isbn"],
        eIsbn: json["eIsbn"],
        eIssn: json["eIssn"],
        ilustrator: json["ilustrator"],
        penulis: json["penulis"],
        hargaBeli: json["hargaBeli"],
        hargaSewa: json["hargaSewa"],
        assetSampulId: json["assetSampulId"],
        namaPenerbitReal: json["namaPenerbitReal"],
        peringatan: json["peringatan"],
        keterangan: json["keterangan"],
        promo: json["promo"] == null ? null : Promo.fromJson(json["promo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "judul": judul,
        "sinopsis": sinopsis,
        "jumlahHalaman": jumlahHalaman,
        "tahunTerbit": tahunTerbit,
        "isbn": isbn,
        "eIsbn": eIsbn,
        "eIssn": eIssn,
        "ilustrator": ilustrator,
        "penulis": penulis,
        "hargaBeli": hargaBeli,
        "hargaSewa": hargaSewa,
        "assetSampulId": assetSampulId,
        "namaPenerbitReal": namaPenerbitReal,
        "peringatan": peringatan,
        "keterangan": keterangan,
        "promo": promo?.toJson(),
      };
}

class Promo {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? mulaiPromo;
  final DateTime? batasPromo;
  final String? tipe;
  final int? jumlah;

  Promo({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.mulaiPromo,
    this.batasPromo,
    this.tipe,
    this.jumlah,
  });

  Promo copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? mulaiPromo,
    DateTime? batasPromo,
    String? tipe,
    int? jumlah,
  }) =>
      Promo(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        mulaiPromo: mulaiPromo ?? this.mulaiPromo,
        batasPromo: batasPromo ?? this.batasPromo,
        tipe: tipe ?? this.tipe,
        jumlah: jumlah ?? this.jumlah,
      );

  factory Promo.fromRawJson(String str) => Promo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Promo.fromJson(Map<String, dynamic> json) => Promo(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        mulaiPromo: json["mulaiPromo"] == null ? null : DateTime.parse(json["mulaiPromo"]),
        batasPromo: json["batasPromo"] == null ? null : DateTime.parse(json["batasPromo"]),
        tipe: json["tipe"],
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "mulaiPromo": mulaiPromo?.toIso8601String(),
        "batasPromo": batasPromo?.toIso8601String(),
        "tipe": tipe,
        "jumlah": jumlah,
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
  final String? urlFotoProfil;
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
    String? urlFotoProfil,
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
  final String? npsn;
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
    this.npsn,
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
    String? npsn,
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
        npsn: npsn ?? this.npsn,
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
        npsn: json["NPSN"],
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
        "NPSN": npsn,
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
