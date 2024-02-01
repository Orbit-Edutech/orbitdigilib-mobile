import 'dart:convert';

class VoucherInfoAll {
  final List<GetVoucher>? listGetVoucher;

  VoucherInfoAll({
    this.listGetVoucher,
  });

  VoucherInfoAll copyWith({
    List<GetVoucher>? listGetVoucher,
  }) =>
      VoucherInfoAll(
        listGetVoucher: listGetVoucher ?? this.listGetVoucher,
      );

  factory VoucherInfoAll.fromRawJson(String str) => VoucherInfoAll.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VoucherInfoAll.fromJson(Map<String, dynamic> json) => VoucherInfoAll(
        listGetVoucher: json["listGetVoucher"] == null
            ? []
            : List<GetVoucher>.from(json["listGetVoucher"]!.map((x) => GetVoucher.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listGetVoucher": listGetVoucher == null ? [] : List<dynamic>.from(listGetVoucher!.map((x) => x.toJson())),
      };
}

class GetVoucher {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? judul;
  final String? link;
  final Icon? icon;

  GetVoucher({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.judul,
    this.link,
    this.icon,
  });

  GetVoucher copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? judul,
    String? link,
    Icon? icon,
  }) =>
      GetVoucher(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        judul: judul ?? this.judul,
        link: link ?? this.link,
        icon: icon ?? this.icon,
      );

  factory GetVoucher.fromRawJson(String str) => GetVoucher.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetVoucher.fromJson(Map<String, dynamic> json) => GetVoucher(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        judul: json["judul"],
        link: json["link"],
        icon: json["icon"] == null ? null : Icon.fromJson(json["icon"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "judul": judul,
        "link": link,
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
