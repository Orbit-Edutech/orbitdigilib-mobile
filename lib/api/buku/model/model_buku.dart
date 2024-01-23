import 'dart:convert';

class ModelBuku {
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
  final Katalog? katalog;
  final Penerbit? penerbit;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? assetBukuId;

  ModelBuku({
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
    this.katalog,
    this.penerbit,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.assetBukuId,
  });

  ModelBuku copyWith({
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
    Katalog? katalog,
    Penerbit? penerbit,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? assetBukuId,
  }) =>
      ModelBuku(
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
        katalog: katalog ?? this.katalog,
        penerbit: penerbit ?? this.penerbit,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        assetBukuId: assetBukuId ?? this.assetBukuId,
      );

  factory ModelBuku.fromRawJson(String str) => ModelBuku.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelBuku.fromJson(Map<String, dynamic> json) => ModelBuku(
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
        katalog: json["katalog"] == null ? null : Katalog.fromJson(json["katalog"]),
        penerbit: json["penerbit"] == null ? null : Penerbit.fromJson(json["penerbit"]),
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        assetBukuId: json["assetBukuId"],
      );

  Map<String, dynamic> toJson() => {
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
        "katalog": katalog?.toJson(),
        "penerbit": penerbit?.toJson(),
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "assetBukuId": assetBukuId,
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
