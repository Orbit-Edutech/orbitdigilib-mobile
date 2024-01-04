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
  final Buku? buku;

  Wishlist({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.buku,
  });

  Wishlist copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Buku? buku,
  }) =>
      Wishlist(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        buku: buku ?? this.buku,
      );

  factory Wishlist.fromRawJson(String str) => Wishlist.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Wishlist.fromJson(Map<String, dynamic> json) => Wishlist(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        buku: json["buku"] == null ? null : Buku.fromJson(json["buku"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "buku": buku?.toJson(),
      };
}

class Buku {
  final String? id;
  final String? judul;
  final int? jumlahHalaman;
  final String? tahunTerbit;
  final String? bahasa;
  final String? penulis;
  final String? hargaBeli;
  final String? hargaSewa;
  final String? assetSampulId;

  Buku({
    this.id,
    this.judul,
    this.jumlahHalaman,
    this.tahunTerbit,
    this.bahasa,
    this.penulis,
    this.hargaBeli,
    this.hargaSewa,
    this.assetSampulId,
  });

  Buku copyWith({
    String? id,
    String? judul,
    int? jumlahHalaman,
    String? tahunTerbit,
    String? bahasa,
    String? penulis,
    String? hargaBeli,
    String? hargaSewa,
    String? assetSampulId,
  }) =>
      Buku(
        id: id ?? this.id,
        judul: judul ?? this.judul,
        jumlahHalaman: jumlahHalaman ?? this.jumlahHalaman,
        tahunTerbit: tahunTerbit ?? this.tahunTerbit,
        bahasa: bahasa ?? this.bahasa,
        penulis: penulis ?? this.penulis,
        hargaBeli: hargaBeli ?? this.hargaBeli,
        hargaSewa: hargaSewa ?? this.hargaSewa,
        assetSampulId: assetSampulId ?? this.assetSampulId,
      );

  factory Buku.fromRawJson(String str) => Buku.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Buku.fromJson(Map<String, dynamic> json) => Buku(
        id: json["id"],
        judul: json["judul"],
        jumlahHalaman: json["jumlahHalaman"],
        tahunTerbit: json["tahunTerbit"],
        bahasa: json["bahasa"],
        penulis: json["penulis"],
        hargaBeli: json["hargaBeli"],
        hargaSewa: json["hargaSewa"],
        assetSampulId: json["assetSampulId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "jumlahHalaman": jumlahHalaman,
        "tahunTerbit": tahunTerbit,
        "bahasa": bahasa,
        "penulis": penulis,
        "hargaBeli": hargaBeli,
        "hargaSewa": hargaSewa,
        "assetSampulId": assetSampulId,
      };
}
