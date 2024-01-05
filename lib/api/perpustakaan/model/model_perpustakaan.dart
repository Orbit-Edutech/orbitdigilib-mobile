import 'dart:convert';

class Perpustakaan {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? nama;
  final String? kode;
  final String? noTelepon;
  final String? deskripsi;
  final int? tahunBerdiri;
  final String? warnaDasar;
  final AssetLogo? assetLogo;
  final List<Banner>? banner;
  final bool? isAktif;

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
    this.assetLogo,
    this.banner,
    this.isAktif,
  });

  Perpustakaan copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? nama,
    String? kode,
    String? noTelepon,
    String? deskripsi,
    int? tahunBerdiri,
    String? warnaDasar,
    AssetLogo? assetLogo,
    List<Banner>? banner,
    bool? isAktif,
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
        assetLogo: assetLogo ?? this.assetLogo,
        banner: banner ?? this.banner,
        isAktif: isAktif ?? this.isAktif,
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
        assetLogo: json["assetLogo"] == null ? null : AssetLogo.fromJson(json["assetLogo"]),
        banner: json["banner"] == null ? [] : List<Banner>.from(json["banner"]!.map((x) => Banner.fromJson(x))),
        isAktif: json["isAktif"],
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
        "assetLogo": assetLogo?.toJson(),
        "banner": banner == null ? [] : List<dynamic>.from(banner!.map((x) => x.toJson())),
        "isAktif": isAktif,
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
