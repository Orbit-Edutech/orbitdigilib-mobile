import 'dart:convert';

class BukuPerpustakaan {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Perpustakaan? perpustakaan;
  final Buku? buku;
  final int? jumlahSoftCopy;
  final int? jumlahSiapPinjam;
  final String? bukuId;
  final bool? isPin;
  final bool? isVisible;
  final KatalogBukuPerpustakaan? katalogBukuPerpustakaan;

  BukuPerpustakaan({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.perpustakaan,
    this.buku,
    this.jumlahSoftCopy,
    this.jumlahSiapPinjam,
    this.bukuId,
    this.isPin,
    this.isVisible,
    this.katalogBukuPerpustakaan,
  });

  BukuPerpustakaan copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Perpustakaan? perpustakaan,
    Buku? buku,
    int? jumlahSoftCopy,
    int? jumlahSiapPinjam,
    String? bukuId,
    bool? isPin,
    bool? isVisible,
    KatalogBukuPerpustakaan? katalogBukuPerpustakaan,
  }) =>
      BukuPerpustakaan(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        perpustakaan: perpustakaan ?? this.perpustakaan,
        buku: buku ?? this.buku,
        jumlahSoftCopy: jumlahSoftCopy ?? this.jumlahSoftCopy,
        jumlahSiapPinjam: jumlahSiapPinjam ?? this.jumlahSiapPinjam,
        bukuId: bukuId ?? this.bukuId,
        isPin: isPin ?? this.isPin,
        isVisible: isVisible ?? this.isVisible,
        katalogBukuPerpustakaan: katalogBukuPerpustakaan ?? this.katalogBukuPerpustakaan,
      );

  factory BukuPerpustakaan.fromRawJson(String str) => BukuPerpustakaan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BukuPerpustakaan.fromJson(Map<String, dynamic> json) => BukuPerpustakaan(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        perpustakaan: json["perpustakaan"] == null ? null : Perpustakaan.fromJson(json["perpustakaan"]),
        buku: json["buku"] == null ? null : Buku.fromJson(json["buku"]),
        jumlahSoftCopy: json["jumlahSoftCopy"],
        jumlahSiapPinjam: json["jumlahSiapPinjam"],
        bukuId: json["bukuId"],
        isPin: json["isPin"],
        isVisible: json["isVisible"],
        katalogBukuPerpustakaan: json["katalogBukuPerpustakaan"] == null
            ? null
            : KatalogBukuPerpustakaan.fromJson(json["katalogBukuPerpustakaan"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "perpustakaan": perpustakaan?.toJson(),
        "buku": buku?.toJson(),
        "jumlahSoftCopy": jumlahSoftCopy,
        "jumlahSiapPinjam": jumlahSiapPinjam,
        "bukuId": bukuId,
        "isPin": isPin,
        "isVisible": isVisible,
        "katalogBukuPerpustakaan": katalogBukuPerpustakaan?.toJson(),
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
  final bool? peringatan;
  final String? keterangan;
  final Bahasa? bahasa;
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
    this.peringatan,
    this.keterangan,
    this.bahasa,
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
    bool? peringatan,
    String? keterangan,
    Bahasa? bahasa,
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
        peringatan: peringatan ?? this.peringatan,
        keterangan: keterangan ?? this.keterangan,
        bahasa: bahasa ?? this.bahasa,
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
        peringatan: json["peringatan"],
        keterangan: json["keterangan"],
        bahasa: json["bahasa"] == null ? null : Bahasa.fromJson(json["bahasa"]),
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
        "peringatan": peringatan,
        "keterangan": keterangan,
        "bahasa": bahasa?.toJson(),
        "penerbit": penerbit?.toJson(),
        "promo": promo?.toJson(),
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "assetBukuId": assetBukuId,
      };
}

class Bahasa {
  final String? id;
  final String? bahasaResmi;
  final String? negara;
  final dynamic deletedAt;

  Bahasa({
    this.id,
    this.bahasaResmi,
    this.negara,
    this.deletedAt,
  });

  Bahasa copyWith({
    String? id,
    String? bahasaResmi,
    String? negara,
    dynamic deletedAt,
  }) =>
      Bahasa(
        id: id ?? this.id,
        bahasaResmi: bahasaResmi ?? this.bahasaResmi,
        negara: negara ?? this.negara,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory Bahasa.fromRawJson(String str) => Bahasa.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bahasa.fromJson(Map<String, dynamic> json) => Bahasa(
        id: json["id"],
        bahasaResmi: json["bahasaResmi"],
        negara: json["negara"],
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bahasaResmi": bahasaResmi,
        "negara": negara,
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

class KatalogBukuPerpustakaan {
  final String? id;
  final String? nama;
  final int? urutanDitampilkan;
  final dynamic deletedAt;

  KatalogBukuPerpustakaan({
    this.id,
    this.nama,
    this.urutanDitampilkan,
    this.deletedAt,
  });

  KatalogBukuPerpustakaan copyWith({
    String? id,
    String? nama,
    int? urutanDitampilkan,
    dynamic deletedAt,
  }) =>
      KatalogBukuPerpustakaan(
        id: id ?? this.id,
        nama: nama ?? this.nama,
        urutanDitampilkan: urutanDitampilkan ?? this.urutanDitampilkan,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory KatalogBukuPerpustakaan.fromRawJson(String str) => KatalogBukuPerpustakaan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KatalogBukuPerpustakaan.fromJson(Map<String, dynamic> json) => KatalogBukuPerpustakaan(
        id: json["id"],
        nama: json["nama"],
        urutanDitampilkan: json["urutanDitampilkan"],
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "urutanDitampilkan": urutanDitampilkan,
        "deletedAt": deletedAt,
      };
}

class Perpustakaan {
  final String? id;
  final String? kode;
  final String? nama;
  final dynamic deskripsi;
  final String? noTelepon;
  final String? email;
  final String? tahunBerdiri;
  final String? warnaDasar;
  final String? npsn;

  Perpustakaan({
    this.id,
    this.kode,
    this.nama,
    this.deskripsi,
    this.noTelepon,
    this.email,
    this.tahunBerdiri,
    this.warnaDasar,
    this.npsn,
  });

  Perpustakaan copyWith({
    String? id,
    String? kode,
    String? nama,
    dynamic deskripsi,
    String? noTelepon,
    String? email,
    String? tahunBerdiri,
    String? warnaDasar,
    String? npsn,
  }) =>
      Perpustakaan(
        id: id ?? this.id,
        kode: kode ?? this.kode,
        nama: nama ?? this.nama,
        deskripsi: deskripsi ?? this.deskripsi,
        noTelepon: noTelepon ?? this.noTelepon,
        email: email ?? this.email,
        tahunBerdiri: tahunBerdiri ?? this.tahunBerdiri,
        warnaDasar: warnaDasar ?? this.warnaDasar,
        npsn: npsn ?? this.npsn,
      );

  factory Perpustakaan.fromRawJson(String str) => Perpustakaan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Perpustakaan.fromJson(Map<String, dynamic> json) => Perpustakaan(
        id: json["id"],
        kode: json["kode"],
        nama: json["nama"],
        deskripsi: json["deskripsi"],
        noTelepon: json["noTelepon"],
        email: json["email"],
        tahunBerdiri: json["tahunBerdiri"],
        warnaDasar: json["warnaDasar"],
        npsn: json["NPSN"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode": kode,
        "nama": nama,
        "deskripsi": deskripsi,
        "noTelepon": noTelepon,
        "email": email,
        "tahunBerdiri": tahunBerdiri,
        "warnaDasar": warnaDasar,
        "NPSN": npsn,
      };
}
