import 'dart:convert';

class KategoriPerpusAll {
  final List<KategoriBukuPerpustakaan>? listKategoriBukuPerpustakaan;

  KategoriPerpusAll({
    this.listKategoriBukuPerpustakaan,
  });

  KategoriPerpusAll copyWith({
    List<KategoriBukuPerpustakaan>? listKategoriBukuPerpustakaan,
  }) =>
      KategoriPerpusAll(
        listKategoriBukuPerpustakaan: listKategoriBukuPerpustakaan ?? this.listKategoriBukuPerpustakaan,
      );

  factory KategoriPerpusAll.fromRawJson(String str) => KategoriPerpusAll.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KategoriPerpusAll.fromJson(Map<String, dynamic> json) => KategoriPerpusAll(
        listKategoriBukuPerpustakaan: json["listKategoriBukuPerpustakaan"] == null
            ? []
            : List<KategoriBukuPerpustakaan>.from(
                json["listKategoriBukuPerpustakaan"]!.map((x) => KategoriBukuPerpustakaan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listKategoriBukuPerpustakaan": listKategoriBukuPerpustakaan == null
            ? []
            : List<dynamic>.from(listKategoriBukuPerpustakaan!.map((x) => x.toJson())),
      };
}

class KategoriBukuPerpustakaan {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? nama;
  final Icon? icon;

  KategoriBukuPerpustakaan({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.nama,
    this.icon,
  });

  KategoriBukuPerpustakaan copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? nama,
    Icon? icon,
  }) =>
      KategoriBukuPerpustakaan(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        nama: nama ?? this.nama,
        icon: icon ?? this.icon,
      );

  factory KategoriBukuPerpustakaan.fromRawJson(String str) => KategoriBukuPerpustakaan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory KategoriBukuPerpustakaan.fromJson(Map<String, dynamic> json) => KategoriBukuPerpustakaan(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        nama: json["nama"],
        icon: json["icon"] == null ? null : Icon.fromJson(json["icon"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "nama": nama,
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
