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
  final dynamic waktuHabis;
  final BukuAnggota? bukuAnggota;

  Payload({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.tipe,
    this.harga,
    this.waktuHabis,
    this.bukuAnggota,
  });

  Payload copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? tipe,
    String? harga,
    dynamic waktuHabis,
    BukuAnggota? bukuAnggota,
  }) =>
      Payload(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        tipe: tipe ?? this.tipe,
        harga: harga ?? this.harga,
        waktuHabis: waktuHabis ?? this.waktuHabis,
        bukuAnggota: bukuAnggota ?? this.bukuAnggota,
      );

  factory Payload.fromRawJson(String str) => Payload.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        tipe: json["tipe"],
        harga: json["harga"],
        waktuHabis: json["waktuHabis"],
        bukuAnggota: json["bukuAnggota"] == null ? null : BukuAnggota.fromJson(json["bukuAnggota"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "tipe": tipe,
        "harga": harga,
        "waktuHabis": waktuHabis,
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
