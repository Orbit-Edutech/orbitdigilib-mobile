import 'dart:convert';

class WishlistAll {
  final List<Wishlist>? listWishlist;

  WishlistAll({
    this.listWishlist,
  });

  WishlistAll copyWith({
    List<Wishlist>? listWishlist,
  }) =>
      WishlistAll(
        listWishlist: listWishlist ?? this.listWishlist,
      );

  factory WishlistAll.fromRawJson(String str) => WishlistAll.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WishlistAll.fromJson(Map<String, dynamic> json) => WishlistAll(
        listWishlist:
            json["listWishlist"] == null ? [] : List<Wishlist>.from(json["listWishlist"]!.map((x) => Wishlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listWishlist": listWishlist == null ? [] : List<dynamic>.from(listWishlist!.map((x) => x.toJson())),
      };
}

class Wishlist {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final BukuPerpustakaan? bukuPerpustakaan;

  Wishlist({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.bukuPerpustakaan,
  });

  Wishlist copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    BukuPerpustakaan? bukuPerpustakaan,
  }) =>
      Wishlist(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        bukuPerpustakaan: bukuPerpustakaan ?? this.bukuPerpustakaan,
      );

  factory Wishlist.fromRawJson(String str) => Wishlist.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        bukuPerpustakaan: json["bukuPerpustakaan"] == null ? null : BukuPerpustakaan.fromJson(json["bukuPerpustakaan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "bukuPerpustakaan": bukuPerpustakaan?.toJson(),
      };
}

class BukuPerpustakaan {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Buku? buku;
  final int? jumlahSoftCopy;
  final int? jumlahSiapPinjam;
  final bool? isPin;
  final dynamic kategoriBukuPerpustakaanId;

  BukuPerpustakaan({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.buku,
    this.jumlahSoftCopy,
    this.jumlahSiapPinjam,
    this.isPin,
    this.kategoriBukuPerpustakaanId,
  });

  BukuPerpustakaan copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Buku? buku,
    int? jumlahSoftCopy,
    int? jumlahSiapPinjam,
    bool? isPin,
    dynamic kategoriBukuPerpustakaanId,
  }) =>
      BukuPerpustakaan(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        buku: buku ?? this.buku,
        jumlahSoftCopy: jumlahSoftCopy ?? this.jumlahSoftCopy,
        jumlahSiapPinjam: jumlahSiapPinjam ?? this.jumlahSiapPinjam,
        isPin: isPin ?? this.isPin,
        kategoriBukuPerpustakaanId: kategoriBukuPerpustakaanId ?? this.kategoriBukuPerpustakaanId,
      );

  factory BukuPerpustakaan.fromRawJson(String str) => BukuPerpustakaan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BukuPerpustakaan.fromJson(Map<String, dynamic> json) => BukuPerpustakaan(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        buku: json["buku"] == null ? null : Buku.fromJson(json["buku"]),
        jumlahSoftCopy: json["jumlahSoftCopy"],
        jumlahSiapPinjam: json["jumlahSiapPinjam"],
        isPin: json["isPin"],
        kategoriBukuPerpustakaanId: json["kategoriBukuPerpustakaanId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "buku": buku?.toJson(),
        "jumlahSoftCopy": jumlahSoftCopy,
        "jumlahSiapPinjam": jumlahSiapPinjam,
        "isPin": isPin,
        "kategoriBukuPerpustakaanId": kategoriBukuPerpustakaanId,
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
  final Penerbit? penerbit;

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
    this.penerbit,
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
    Penerbit? penerbit,
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
        penerbit: penerbit ?? this.penerbit,
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
        penerbit: json["penerbit"] == null ? null : Penerbit.fromJson(json["penerbit"]),
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
        "penerbit": penerbit?.toJson(),
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
