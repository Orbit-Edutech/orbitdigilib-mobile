import 'dart:convert';

// TODO: Ini model perpustakaan yang udah komplit
class AuthPerpustakaan {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? nama;
  final String? kode;
  final String? noTelepon;
  final String? deskripsi;
  final int? tahunBerdiri;
  final String? warnaDasar;
  final String? assetLogo;
  final List<String>? banner;
  final bool? isAktif;

  AuthPerpustakaan({
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

  AuthPerpustakaan copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? nama,
    String? kode,
    String? noTelepon,
    String? deskripsi,
    int? tahunBerdiri,
    String? warnaDasar,
    String? assetLogo,
    List<String>? banner,
    bool? isAktif,
  }) =>
      AuthPerpustakaan(
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

  factory AuthPerpustakaan.fromRawJson(String str) => AuthPerpustakaan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthPerpustakaan.fromJson(Map<String, dynamic> json) => AuthPerpustakaan(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        nama: json["nama"],
        kode: json["kode"],
        noTelepon: json["noTelepon"],
        deskripsi: json["deskripsi"],
        tahunBerdiri: json["tahunBerdiri"],
        warnaDasar: json["warnaDasar"],
        assetLogo: json["assetLogo"],
        banner: json["banner"] == null ? [] : List<String>.from(json["banner"]!.map((x) => x)),
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
        "assetLogo": assetLogo,
        "banner": banner == null ? [] : List<String>.from(banner!.map((x) => x)),
        "isAktif": isAktif,
      };
}
