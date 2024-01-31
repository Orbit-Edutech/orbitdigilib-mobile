import 'dart:convert';

class KategoriPerpusAll {
  final List<KatalogBukuPerpustakaan>? listKatalogBukuPerpustakaan;

  KategoriPerpusAll({
    this.listKatalogBukuPerpustakaan,
  });

  KategoriPerpusAll copyWith({
    List<KatalogBukuPerpustakaan>? listKatalogBukuPerpustakaan,
  }) =>
      KategoriPerpusAll(
        listKatalogBukuPerpustakaan: listKatalogBukuPerpustakaan ?? this.listKatalogBukuPerpustakaan,
      );

  factory KategoriPerpusAll.fromRawJson(String str) => KategoriPerpusAll.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KategoriPerpusAll.fromJson(Map<String, dynamic> json) => KategoriPerpusAll(
        listKatalogBukuPerpustakaan: json["listKatalogBukuPerpustakaan"] == null
            ? []
            : List<KatalogBukuPerpustakaan>.from(
                json["listKatalogBukuPerpustakaan"]!.map((x) => KatalogBukuPerpustakaan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listKatalogBukuPerpustakaan": listKatalogBukuPerpustakaan == null
            ? []
            : List<dynamic>.from(listKatalogBukuPerpustakaan!.map((x) => x.toJson())),
      };
}

class KatalogBukuPerpustakaan {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? nama;
  final int? urutanDitampilkan;
  final Icon? icon;

  KatalogBukuPerpustakaan({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.nama,
    this.urutanDitampilkan,
    this.icon,
  });

  KatalogBukuPerpustakaan copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? nama,
    int? urutanDitampilkan,
    Icon? icon,
  }) =>
      KatalogBukuPerpustakaan(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        nama: nama ?? this.nama,
        urutanDitampilkan: urutanDitampilkan ?? this.urutanDitampilkan,
        icon: icon ?? this.icon,
      );

  factory KatalogBukuPerpustakaan.fromRawJson(String str) => KatalogBukuPerpustakaan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KatalogBukuPerpustakaan.fromJson(Map<String, dynamic> json) => KatalogBukuPerpustakaan(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        nama: json["nama"],
        urutanDitampilkan: json["urutanDitampilkan"],
        icon: json["icon"] == null ? null : Icon.fromJson(json["icon"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "nama": nama,
        "urutanDitampilkan": urutanDitampilkan,
        "icon": icon?.toJson(),
      };
}

class Icon {
  final String? id;
  final String? originalName;

  Icon({
    this.id,
    this.originalName,
  });

  Icon copyWith({
    String? id,
    String? originalName,
  }) =>
      Icon(
        id: id ?? this.id,
        originalName: originalName ?? this.originalName,
      );

  factory Icon.fromRawJson(String str) => Icon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Icon.fromJson(Map<String, dynamic> json) => Icon(
        id: json["id"],
        originalName: json["originalName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "originalName": originalName,
      };
}
