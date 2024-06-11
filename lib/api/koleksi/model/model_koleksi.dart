import 'dart:convert';

class ModelKoleksi {
  final int? totalAllData;
  final int? totalData;
  final int? limit;
  final int? totalPage;
  final int? currentPage;
  final int? lastPage;
  final int? nextPage;
  final dynamic previousPage;
  final List<Payload>? payload;

  ModelKoleksi({
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

  ModelKoleksi copyWith({
    int? totalAllData,
    int? totalData,
    int? limit,
    int? totalPage,
    int? currentPage,
    int? lastPage,
    int? nextPage,
    dynamic previousPage,
    List<Payload>? payload,
  }) =>
      ModelKoleksi(
        totalAllData: totalAllData ?? this.totalAllData,
        totalData: totalData ?? this.totalData,
        limit: limit ?? this.limit,
        totalPage: totalPage ?? this.totalPage,
        currentPage: currentPage ?? this.currentPage,
        lastPage: lastPage ?? this.lastPage,
        nextPage: nextPage ?? this.nextPage,
        previousPage: previousPage ?? this.previousPage,
        payload: payload ?? this.payload,
      );

  factory ModelKoleksi.fromRawJson(String str) => ModelKoleksi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelKoleksi.fromJson(Map<String, dynamic> json) => ModelKoleksi(
        totalAllData: json["totalAllData"],
        totalData: json["totalData"],
        limit: json["limit"],
        totalPage: json["totalPage"],
        currentPage: json["currentPage"],
        lastPage: json["lastPage"],
        nextPage: json["nextPage"],
        previousPage: json["previousPage"],
        payload: json["payload"] == null ? [] : List<Payload>.from(json["payload"]!.map((x) => Payload.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalAllData": totalAllData,
        "totalData": totalData,
        "limit": limit,
        "totalPage": totalPage,
        "currentPage": currentPage,
        "lastPage": lastPage,
        "nextPage": nextPage,
        "previousPage": previousPage,
        "payload": payload == null ? [] : List<dynamic>.from(payload!.map((x) => x.toJson())),
      };
}

class Payload {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? tipe;
  final String? harga;
  final DateTime? waktuHabis;
  final Buku? buku;

  Payload({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.tipe,
    this.harga,
    this.waktuHabis,
    this.buku,
  });

  Payload copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? tipe,
    String? harga,
    DateTime? waktuHabis,
    Buku? buku,
  }) =>
      Payload(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        tipe: tipe ?? this.tipe,
        harga: harga ?? this.harga,
        waktuHabis: waktuHabis ?? this.waktuHabis,
        buku: buku ?? this.buku,
      );

  factory Payload.fromRawJson(String str) => Payload.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        tipe: json["tipe"],
        harga: json["harga"],
        waktuHabis: json["waktuHabis"] == null ? null : DateTime.parse(json["waktuHabis"]),
        buku: json["buku"] == null ? null : Buku.fromJson(json["buku"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "tipe": tipe,
        "harga": harga,
        "waktuHabis": waktuHabis?.toIso8601String(),
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
  final Kategori? kategori;
  final Penerbit? penerbit;
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
    this.kategori,
    this.penerbit,
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
    Kategori? kategori,
    Penerbit? penerbit,
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
        kategori: kategori ?? this.kategori,
        penerbit: penerbit ?? this.penerbit,
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
        kategori: json["kategori"] == null ? null : Kategori.fromJson(json["kategori"]),
        penerbit: json["penerbit"] == null ? null : Penerbit.fromJson(json["penerbit"]),
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
        "kategori": kategori?.toJson(),
        "penerbit": penerbit?.toJson(),
        "promo": promo?.toJson(),
      };
}

class Kategori {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? nama;
  final dynamic deletedAt;

  Kategori({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.nama,
    this.deletedAt,
  });

  Kategori copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? nama,
    dynamic deletedAt,
  }) =>
      Kategori(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        nama: nama ?? this.nama,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory Kategori.fromRawJson(String str) => Kategori.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        nama: json["nama"],
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "nama": nama,
        "deletedAt": deletedAt,
      };
}

class Penerbit {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? nama;
  final String? kode;
  final String? noTelepon;
  final dynamic deskripsi;
  final String? email;
  final String? namaPic;
  final String? contactPersonPic;
  final String? tahunBerdiri;

  Penerbit({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.nama,
    this.kode,
    this.noTelepon,
    this.deskripsi,
    this.email,
    this.namaPic,
    this.contactPersonPic,
    this.tahunBerdiri,
  });

  Penerbit copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? nama,
    String? kode,
    String? noTelepon,
    dynamic deskripsi,
    String? email,
    String? namaPic,
    String? contactPersonPic,
    String? tahunBerdiri,
  }) =>
      Penerbit(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        nama: nama ?? this.nama,
        kode: kode ?? this.kode,
        noTelepon: noTelepon ?? this.noTelepon,
        deskripsi: deskripsi ?? this.deskripsi,
        email: email ?? this.email,
        namaPic: namaPic ?? this.namaPic,
        contactPersonPic: contactPersonPic ?? this.contactPersonPic,
        tahunBerdiri: tahunBerdiri ?? this.tahunBerdiri,
      );

  factory Penerbit.fromRawJson(String str) => Penerbit.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Penerbit.fromJson(Map<String, dynamic> json) => Penerbit(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        nama: json["nama"],
        kode: json["kode"],
        noTelepon: json["noTelepon"],
        deskripsi: json["deskripsi"],
        email: json["email"],
        namaPic: json["namaPIC"],
        contactPersonPic: json["contactPersonPIC"],
        tahunBerdiri: json["tahunBerdiri"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "nama": nama,
        "kode": kode,
        "noTelepon": noTelepon,
        "deskripsi": deskripsi,
        "email": email,
        "namaPIC": namaPic,
        "contactPersonPIC": contactPersonPic,
        "tahunBerdiri": tahunBerdiri,
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
