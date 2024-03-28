import 'dart:convert';

class BannerDefault {
  final int? totalData;
  final List<Banner>? listBanner;

  BannerDefault({
    this.totalData,
    this.listBanner,
  });

  BannerDefault copyWith({
    int? totalData,
    List<Banner>? listBanner,
  }) =>
      BannerDefault(
        totalData: totalData ?? this.totalData,
        listBanner: listBanner ?? this.listBanner,
      );

  factory BannerDefault.fromRawJson(String str) => BannerDefault.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BannerDefault.fromJson(Map<String, dynamic> json) => BannerDefault(
        totalData: json["totalData"],
        listBanner: json["listBanner"] == null ? [] : List<Banner>.from(json["listBanner"]!.map((x) => Banner.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalData": totalData,
        "listBanner": listBanner == null ? [] : List<dynamic>.from(listBanner!.map((x) => x.toJson())),
      };
}

class Banner {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? originalName;
  final int? size;

  Banner({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.originalName,
    this.size,
  });

  Banner copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? originalName,
    int? size,
  }) =>
      Banner(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        originalName: originalName ?? this.originalName,
        size: size ?? this.size,
      );

  factory Banner.fromRawJson(String str) => Banner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
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
