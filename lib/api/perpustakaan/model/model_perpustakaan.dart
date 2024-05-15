import 'dart:convert';

class Perpustakaan {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? nama;
  final String? kode;
  final String? noTelepon;
  final String? deskripsi;
  final dynamic tahunBerdiri;
  final String? warnaDasar;
  final String? email;
  final String? namaPic;
  final String? contactPersonPic;
  final String? npsn;
  final AssetLogo? assetLogo;
  final List<Banner>? banner;
  final bool? isAktif;
  final Alamat? alamat;

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
    this.assetLogo,
    this.banner,
    this.isAktif,
    this.alamat,
  });

  Perpustakaan copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? nama,
    String? kode,
    String? noTelepon,
    String? deskripsi,
    dynamic tahunBerdiri,
    String? warnaDasar,
    String? email,
    String? namaPic,
    String? contactPersonPic,
    String? npsn,
    AssetLogo? assetLogo,
    List<Banner>? banner,
    bool? isAktif,
    Alamat? alamat,
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
        assetLogo: assetLogo ?? this.assetLogo,
        banner: banner ?? this.banner,
        isAktif: isAktif ?? this.isAktif,
        alamat: alamat ?? this.alamat,
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
        assetLogo: json["assetLogo"] == null ? null : AssetLogo.fromJson(json["assetLogo"]),
        banner: json["banner"] == null ? [] : List<Banner>.from(json["banner"]!.map((x) => Banner.fromJson(x))),
        isAktif: json["isAktif"],
        alamat: json["alamat"] == null ? null : Alamat.fromJson(json["alamat"]),
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
        "assetLogo": assetLogo?.toJson(),
        "banner": banner == null ? [] : List<dynamic>.from(banner!.map((x) => x.toJson())),
        "isAktif": isAktif,
        "alamat": alamat?.toJson(),
      };
}

class Alamat {
  final String? detailAlamat;
  final String? kelurahan;
  final String? kecamatan;
  final String? kabupatenKota;
  final String? provinsi;
  final String? kodePos;

  Alamat({
    this.detailAlamat,
    this.kelurahan,
    this.kecamatan,
    this.kabupatenKota,
    this.provinsi,
    this.kodePos,
  });

  Alamat copyWith({
    String? detailAlamat,
    String? kelurahan,
    String? kecamatan,
    String? kabupatenKota,
    String? provinsi,
    String? kodePos,
  }) =>
      Alamat(
        detailAlamat: detailAlamat ?? this.detailAlamat,
        kelurahan: kelurahan ?? this.kelurahan,
        kecamatan: kecamatan ?? this.kecamatan,
        kabupatenKota: kabupatenKota ?? this.kabupatenKota,
        provinsi: provinsi ?? this.provinsi,
        kodePos: kodePos ?? this.kodePos,
      );

  factory Alamat.fromRawJson(String str) => Alamat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Alamat.fromJson(Map<String, dynamic> json) => Alamat(
        detailAlamat: json["detailAlamat"],
        kelurahan: json["kelurahan"],
        kecamatan: json["kecamatan"],
        kabupatenKota: json["kabupatenKota"],
        provinsi: json["provinsi"],
        kodePos: json["kodePos"],
      );

  Map<String, dynamic> toJson() => {
        "detailAlamat": detailAlamat,
        "kelurahan": kelurahan,
        "kecamatan": kecamatan,
        "kabupatenKota": kabupatenKota,
        "provinsi": provinsi,
        "kodePos": kodePos,
      };
}

class AssetLogo {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? originalName;
  final int? size;

  AssetLogo({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.originalName,
    this.size,
  });

  AssetLogo copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? originalName,
    int? size,
  }) =>
      AssetLogo(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        originalName: originalName ?? this.originalName,
        size: size ?? this.size,
      );

  factory AssetLogo.fromRawJson(String str) => AssetLogo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AssetLogo.fromJson(Map<String, dynamic> json) => AssetLogo(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        originalName: json["originalName"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "originalName": originalName,
        "size": size,
      };
}

class Banner {
  final String? id;
  final String? originalName;

  Banner({
    this.id,
    this.originalName,
  });

  Banner copyWith({
    String? id,
    String? originalName,
  }) =>
      Banner(
        id: id ?? this.id,
        originalName: originalName ?? this.originalName,
      );

  factory Banner.fromRawJson(String str) => Banner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        id: json["id"],
        originalName: json["originalName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "originalName": originalName,
      };
}
