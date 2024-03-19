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
  final dynamic katalogBukuPerpustakaan;

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
    dynamic katalogBukuPerpustakaan,
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
        katalogBukuPerpustakaan: json["katalogBukuPerpustakaan"],
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
        "katalogBukuPerpustakaan": katalogBukuPerpustakaan,
      };
}

class Buku {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? judul;
  final String? sinopsis;
  final int? jumlahHalaman;
  final dynamic tahunTerbit;
  final String? isbn;
  final dynamic eIsbn;
  final dynamic ilustrator;
  final String? penulis;
  final int? hargaBeli;
  final int? hargaSewa;
  final String? assetSampulId;
  final Bahasa? bahasa;
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
    this.ilustrator,
    this.penulis,
    this.hargaBeli,
    this.hargaSewa,
    this.assetSampulId,
    this.bahasa,
    this.penerbit,
  });

  Buku copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? judul,
    String? sinopsis,
    int? jumlahHalaman,
    dynamic tahunTerbit,
    String? isbn,
    dynamic eIsbn,
    dynamic ilustrator,
    String? penulis,
    int? hargaBeli,
    int? hargaSewa,
    String? assetSampulId,
    Bahasa? bahasa,
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
        ilustrator: ilustrator ?? this.ilustrator,
        penulis: penulis ?? this.penulis,
        hargaBeli: hargaBeli ?? this.hargaBeli,
        hargaSewa: hargaSewa ?? this.hargaSewa,
        assetSampulId: assetSampulId ?? this.assetSampulId,
        bahasa: bahasa ?? this.bahasa,
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
        ilustrator: json["ilustrator"],
        penulis: json["penulis"],
        hargaBeli: json["hargaBeli"],
        hargaSewa: json["hargaSewa"],
        assetSampulId: json["assetSampulId"],
        bahasa: json["bahasa"] == null ? null : Bahasa.fromJson(json["bahasa"]),
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
        "ilustrator": ilustrator,
        "penulis": penulis,
        "hargaBeli": hargaBeli,
        "hargaSewa": hargaSewa,
        "assetSampulId": assetSampulId,
        "bahasa": bahasa?.toJson(),
        "penerbit": penerbit?.toJson(),
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
  final String? deskripsi;
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
    String? deskripsi,
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

class Perpustakaan {
  final String? id;
  final String? nama;
  final String? deskripsi;
  final String? noTelepon;
  final dynamic tahunBerdiri;
  final String? warnaDasar;
  final String? namaPic;
  final String? contactPersonPic;

  Perpustakaan({
    this.id,
    this.nama,
    this.deskripsi,
    this.noTelepon,
    this.tahunBerdiri,
    this.warnaDasar,
    this.namaPic,
    this.contactPersonPic,
  });

  Perpustakaan copyWith({
    String? id,
    String? nama,
    String? deskripsi,
    String? noTelepon,
    dynamic tahunBerdiri,
    String? warnaDasar,
    String? namaPic,
    String? contactPersonPic,
  }) =>
      Perpustakaan(
        id: id ?? this.id,
        nama: nama ?? this.nama,
        deskripsi: deskripsi ?? this.deskripsi,
        noTelepon: noTelepon ?? this.noTelepon,
        tahunBerdiri: tahunBerdiri ?? this.tahunBerdiri,
        warnaDasar: warnaDasar ?? this.warnaDasar,
        namaPic: namaPic ?? this.namaPic,
        contactPersonPic: contactPersonPic ?? this.contactPersonPic,
      );

  factory Perpustakaan.fromRawJson(String str) => Perpustakaan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Perpustakaan.fromJson(Map<String, dynamic> json) => Perpustakaan(
        id: json["id"],
        nama: json["nama"],
        deskripsi: json["deskripsi"],
        noTelepon: json["noTelepon"],
        tahunBerdiri: json["tahunBerdiri"],
        warnaDasar: json["warnaDasar"],
        namaPic: json["namaPIC"],
        contactPersonPic: json["contactPersonPIC"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "deskripsi": deskripsi,
        "noTelepon": noTelepon,
        "tahunBerdiri": tahunBerdiri,
        "warnaDasar": warnaDasar,
        "namaPIC": namaPic,
        "contactPersonPIC": contactPersonPic,
      };
}
