import 'dart:convert';

class ModelAllSewa {
  final int? totalAllData;
  final int? totalData;
  final int? limit;
  final int? totalPage;
  final int? currentPage;
  final int? lastPage;
  final dynamic nextPage;
  final dynamic previousPage;
  final List<ModelSewa>? payload;

  ModelAllSewa({
    this.totalAllData,
    this.totalData,
    this.limit,
    this.totalPage,
    this.currentPage,
    this.lastPage,
    this.nextPage,
    this.previousPage,
    this.payload,
  });

  factory ModelAllSewa.fromJson(Map<String, dynamic> json) => ModelAllSewa(
        totalAllData: json["totalAllData"],
        totalData: json["totalData"],
        limit: json["limit"],
        totalPage: json["totalPage"],
        currentPage: json["currentPage"],
        lastPage: json["lastPage"],
        nextPage: json["nextPage"],
        previousPage: json["previousPage"],
        payload: json["payload"] == null
            ? []
            : List<ModelSewa>.from(json["payload"]!.map((x) => ModelSewa.fromJson(x))),
      );
}

class ModelSewa {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? hargaSewa;
  final DateTime? tanggalSewa;
  final DateTime? tanggalHabisSewa;
  final User? user;
  final BukuAnggota? bukuAnggota;

  ModelSewa({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.hargaSewa,
    this.tanggalSewa,
    this.tanggalHabisSewa,
    this.user,
    this.bukuAnggota,
  });

  ModelSewa copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? hargaSewa,
    DateTime? tanggalSewa,
    DateTime? tanggalHabisSewa,
    User? user,
    BukuAnggota? bukuAnggota,
  }) =>
      ModelSewa(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        hargaSewa: hargaSewa ?? this.hargaSewa,
        tanggalSewa: tanggalSewa ?? this.tanggalSewa,
        tanggalHabisSewa: tanggalHabisSewa ?? this.tanggalHabisSewa,
        user: user ?? this.user,
        bukuAnggota: bukuAnggota ?? this.bukuAnggota,
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
        bukuAnggota: json["bukuAnggota"] == null ? null : BukuAnggota.fromJson(json["bukuAnggota"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "hargaSewa": hargaSewa,
        "tanggalSewa": tanggalSewa?.toIso8601String(),
        "tanggalHabisSewa": tanggalHabisSewa?.toIso8601String(),
        "user": user?.toJson(),
        "bukuAnggota": bukuAnggota?.toJson(),
      };
}

class BukuAnggota {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? namaKategori;
  final String? namaPenerbit;
  final String? judul;
  final String? sinopsis;
  final int? jumlahHalaman;
  final String? tahunTerbit;
  final String? isbn;
  final String? eIsbn;
  final String? bahasa;
  final String? penulis;
  final String? ilustrator;
  final String? assetSampulId;
  final String? assetBukuId;

  BukuAnggota({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.namaKategori,
    this.namaPenerbit,
    this.judul,
    this.sinopsis,
    this.jumlahHalaman,
    this.tahunTerbit,
    this.isbn,
    this.eIsbn,
    this.bahasa,
    this.penulis,
    this.ilustrator,
    this.assetSampulId,
    this.assetBukuId,
  });

  BukuAnggota copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? namaKategori,
    String? namaPenerbit,
    String? judul,
    String? sinopsis,
    int? jumlahHalaman,
    String? tahunTerbit,
    String? isbn,
    String? eIsbn,
    String? bahasa,
    String? penulis,
    String? ilustrator,
    String? assetSampulId,
    String? assetBukuId,
  }) =>
      BukuAnggota(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        namaKategori: namaKategori ?? this.namaKategori,
        namaPenerbit: namaPenerbit ?? this.namaPenerbit,
        judul: judul ?? this.judul,
        sinopsis: sinopsis ?? this.sinopsis,
        jumlahHalaman: jumlahHalaman ?? this.jumlahHalaman,
        tahunTerbit: tahunTerbit ?? this.tahunTerbit,
        isbn: isbn ?? this.isbn,
        eIsbn: eIsbn ?? this.eIsbn,
        bahasa: bahasa ?? this.bahasa,
        penulis: penulis ?? this.penulis,
        ilustrator: ilustrator ?? this.ilustrator,
        assetSampulId: assetSampulId ?? this.assetSampulId,
        assetBukuId: assetBukuId ?? this.assetBukuId,
      );

  factory BukuAnggota.fromRawJson(String str) => BukuAnggota.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BukuAnggota.fromJson(Map<String, dynamic> json) => BukuAnggota(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        namaKategori: json["namaKategori"],
        namaPenerbit: json["namaPenerbit"],
        judul: json["judul"],
        sinopsis: json["sinopsis"],
        jumlahHalaman: json["jumlahHalaman"],
        tahunTerbit: json["tahunTerbit"],
        isbn: json["isbn"],
        eIsbn: json["eIsbn"],
        bahasa: json["bahasa"],
        penulis: json["penulis"],
        ilustrator: json["ilustrator"],
        assetSampulId: json["assetSampulId"],
        assetBukuId: json["assetBukuId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "namaKategori": namaKategori,
        "namaPenerbit": namaPenerbit,
        "judul": judul,
        "sinopsis": sinopsis,
        "jumlahHalaman": jumlahHalaman,
        "tahunTerbit": tahunTerbit,
        "isbn": isbn,
        "eIsbn": eIsbn,
        "bahasa": bahasa,
        "penulis": penulis,
        "ilustrator": ilustrator,
        "assetSampulId": assetSampulId,
        "assetBukuId": assetBukuId,
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
