import 'dart:convert';

class ModelKoleksi {
  final int? totalAllData;
  final int? totalData;
  final int? limit;
  final int? totalPage;
  final int? currentPage;
  final int? lastPage;
  final dynamic nextPage;
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
    dynamic nextPage,
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
  final int? harga;
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
    int? harga,
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
  final String? bahasa;
  final String? ilustrator;
  final String? penulis;
  final String? hargaBeli;
  final String? hargaSewa;
  final String? assetSampulId;
  final String? assetBukuId;
  final Katalog? katalog;
  final Penerbit? penerbit;
  final dynamic promo;

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
    this.bahasa,
    this.ilustrator,
    this.penulis,
    this.hargaBeli,
    this.hargaSewa,
    this.assetSampulId,
    this.assetBukuId,
    this.katalog,
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
    String? bahasa,
    String? ilustrator,
    String? penulis,
    String? hargaBeli,
    String? hargaSewa,
    String? assetSampulId,
    String? assetBukuId,
    Katalog? katalog,
    Penerbit? penerbit,
    dynamic promo,
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
        bahasa: bahasa ?? this.bahasa,
        ilustrator: ilustrator ?? this.ilustrator,
        penulis: penulis ?? this.penulis,
        hargaBeli: hargaBeli ?? this.hargaBeli,
        hargaSewa: hargaSewa ?? this.hargaSewa,
        assetSampulId: assetSampulId ?? this.assetSampulId,
        assetBukuId: assetBukuId ?? this.assetBukuId,
        katalog: katalog ?? this.katalog,
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
        bahasa: json["bahasa"],
        ilustrator: json["ilustrator"],
        penulis: json["penulis"],
        hargaBeli: json["hargaBeli"],
        hargaSewa: json["hargaSewa"],
        assetSampulId: json["assetSampulId"],
        assetBukuId: json["assetBukuId"],
        katalog: json["katalog"] == null ? null : Katalog.fromJson(json["katalog"]),
        penerbit: json["penerbit"] == null ? null : Penerbit.fromJson(json["penerbit"]),
        promo: json["promo"],
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
        "bahasa": bahasa,
        "ilustrator": ilustrator,
        "penulis": penulis,
        "hargaBeli": hargaBeli,
        "hargaSewa": hargaSewa,
        "assetSampulId": assetSampulId,
        "assetBukuId": assetBukuId,
        "katalog": katalog?.toJson(),
        "penerbit": penerbit?.toJson(),
        "promo": promo,
      };
}

class Katalog {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? nama;

  Katalog({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.nama,
  });

  Katalog copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? nama,
  }) =>
      Katalog(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        nama: nama ?? this.nama,
      );

  factory Katalog.fromRawJson(String str) => Katalog.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Katalog.fromJson(Map<String, dynamic> json) => Katalog(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "nama": nama,
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
  final String? tahunBerdiri;

  Penerbit({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.nama,
    this.kode,
    this.noTelepon,
    this.deskripsi,
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
        "tahunBerdiri": tahunBerdiri,
      };
}
