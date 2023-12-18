import 'dart:convert';

class Perpus {
  final String? name;
  final String? kode;
  final String? color;
  final String? logo;

  Perpus({
    this.name,
    this.kode,
    this.color,
    this.logo,
  });

  factory Perpus.fromRawJson(String str) => Perpus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Perpus.fromJson(Map<String, dynamic> json) => Perpus(
        name: json["name"],
        kode: json["kode"],
        color: json["color"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "kode": kode,
        "color": color,
        "logo": logo,
      };
}
