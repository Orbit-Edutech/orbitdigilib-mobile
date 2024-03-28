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
  final String? bukuId;
  final bool? isPin;
  final bool? isVisible;

  BukuPerpustakaan({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.buku,
    this.jumlahSoftCopy,
    this.jumlahSiapPinjam,
    this.bukuId,
    this.isPin,
    this.isVisible,
  });

  BukuPerpustakaan copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Buku? buku,
    int? jumlahSoftCopy,
    int? jumlahSiapPinjam,
    String? bukuId,
    bool? isPin,
    bool? isVisible,
  }) =>
      BukuPerpustakaan(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        buku: buku ?? this.buku,
        jumlahSoftCopy: jumlahSoftCopy ?? this.jumlahSoftCopy,
        jumlahSiapPinjam: jumlahSiapPinjam ?? this.jumlahSiapPinjam,
        bukuId: bukuId ?? this.bukuId,
        isPin: isPin ?? this.isPin,
        isVisible: isVisible ?? this.isVisible,
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
        bukuId: json["bukuId"],
        isPin: json["isPin"],
        isVisible: json["isVisible"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "buku": buku?.toJson(),
        "jumlahSoftCopy": jumlahSoftCopy,
        "jumlahSiapPinjam": jumlahSiapPinjam,
        "bukuId": bukuId,
        "isPin": isPin,
        "isVisible": isVisible,
      };
}

class Buku {
  final String? judul;
  final String? sinopsis;
  final int? jumlahHalaman;
  final String? tahunTerbit;
  final String? isbn;
  final String? eIsbn;
  final String? ilustrator;
  final String? penulis;
  final int? hargaBeli;
  final int? hargaSewa;
  final String? assetSampulId;
  final dynamic namaPenerbitReal;
  final Penerbit? penerbit;
  final Promo? promo;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? assetBukuId;

  Buku({
    this.judul,
    this.sinopsis,
    this.jumlahHalaman,
    this.tahunTerbit,
    this.isbn,
    this.eIsbn,
    this.ilustrator,
    this.penulis,
    this.hargaBeli,
    this.hargaSewa,
    this.assetSampulId,
    this.namaPenerbitReal,
    this.penerbit,
    this.promo,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.assetBukuId,
  });

  Buku copyWith({
    String? judul,
    String? sinopsis,
    int? jumlahHalaman,
    String? tahunTerbit,
    String? isbn,
    String? eIsbn,
    String? ilustrator,
    String? penulis,
    int? hargaBeli,
    int? hargaSewa,
    String? assetSampulId,
    dynamic namaPenerbitReal,
    Penerbit? penerbit,
    Promo? promo,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? assetBukuId,
  }) =>
      Buku(
        judul: judul ?? this.judul,
        sinopsis: sinopsis ?? this.sinopsis,
        jumlahHalaman: jumlahHalaman ?? this.jumlahHalaman,
        tahunTerbit: tahunTerbit ?? this.tahunTerbit,
        isbn: isbn ?? this.isbn,
        eIsbn: eIsbn ?? this.eIsbn,
        ilustrator: ilustrator ?? this.ilustrator,
        penulis: penulis ?? this.penulis,
        hargaBeli: hargaBeli ?? this.hargaBeli,
        hargaSewa: hargaSewa ?? this.hargaSewa,
        assetSampulId: assetSampulId ?? this.assetSampulId,
        namaPenerbitReal: namaPenerbitReal ?? this.namaPenerbitReal,
        penerbit: penerbit ?? this.penerbit,
        promo: promo ?? this.promo,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        assetBukuId: assetBukuId ?? this.assetBukuId,
      );

  factory Buku.fromRawJson(String str) => Buku.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Buku.fromJson(Map<String, dynamic> json) => Buku(
        judul: json["judul"],
        sinopsis: json["sinopsis"],
        jumlahHalaman: json["jumlahHalaman"],
        tahunTerbit: json["tahunTerbit"],
        isbn: json["isbn"],
        eIsbn: json["eIsbn"],
        ilustrator: json["ilustrator"],
        penulis: json["penulis"],
        hargaBeli: json["hargaBeli"],
        hargaSewa: json["hargaSewa"],
        assetSampulId: json["assetSampulId"],
        namaPenerbitReal: json["namaPenerbitReal"],
        penerbit: json["penerbit"] == null ? null : Penerbit.fromJson(json["penerbit"]),
        promo: json["promo"] == null ? null : Promo.fromJson(json["promo"]),
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
        "ilustrator": ilustrator,
        "penulis": penulis,
        "hargaBeli": hargaBeli,
        "hargaSewa": hargaSewa,
        "assetSampulId": assetSampulId,
        "namaPenerbitReal": namaPenerbitReal,
        "penerbit": penerbit?.toJson(),
        "promo": promo?.toJson(),
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "assetBukuId": assetBukuId,
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
  final DateTime? batasPromo;
  final String? tipe;
  final int? jumlah;

  Promo({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.batasPromo,
    this.tipe,
    this.jumlah,
  });

  Promo copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? batasPromo,
    String? tipe,
    int? jumlah,
  }) =>
      Promo(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
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
        batasPromo: json["batasPromo"] == null ? null : DateTime.parse(json["batasPromo"]),
        tipe: json["tipe"],
        jumlah: json["jumlah"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "batasPromo": batasPromo?.toIso8601String(),
        "tipe": tipe,
        "jumlah": jumlah,
      };
}
