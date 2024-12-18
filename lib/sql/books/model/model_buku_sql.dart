import 'dart:convert';

class ModelBukuSql {
  final String idBuku;
  final String idUser;
  final int lastPageSeen;
  final int totalPages;
  final DateTime expired;
  final String status;
  final String? assetSampulPath;
  final String? assetBukuPath;
  final String judul;
  final String penulis;
  final String tipe;

  ModelBukuSql({
    required this.idBuku,
    required this.idUser,
    required this.lastPageSeen,
    required this.totalPages,
    required this.expired,
    required this.status,
    this.assetSampulPath,
    this.assetBukuPath,
    required this.judul,
    required this.penulis,
    required this.tipe,
  });

  ModelBukuSql copyWith({
    String? idBuku,
    String? idUser,
    int? lastPageSeen,
    int? totalPages,
    DateTime? expired,
    String? status,
    String? assetSampulPath,
    String? assetBukuPath,
    String? judul,
    String? penulis,
    String? tipe,
  }) =>
      ModelBukuSql(
        idBuku: idBuku ?? this.idBuku,
        idUser: idUser ?? this.idUser,
        lastPageSeen: lastPageSeen ?? this.lastPageSeen,
        totalPages: totalPages ?? this.totalPages,
        expired: expired ?? this.expired,
        status: status ?? this.status,
        assetSampulPath: assetSampulPath ?? this.assetSampulPath,
        assetBukuPath: assetBukuPath ?? this.assetBukuPath,
        judul: judul ?? this.judul,
        penulis: penulis ?? this.penulis,
        tipe: tipe ?? this.tipe,
      );

  factory ModelBukuSql.fromRawJson(String str) => ModelBukuSql.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelBukuSql.fromJson(Map<String, dynamic> json) => ModelBukuSql(
        idBuku: json["id_buku"],
        idUser: json["id_user"],
        lastPageSeen: json["last_page_seen"],
        totalPages: json["total_pages"],
        expired: DateTime.parse(json["expired"]),
        status: json["status"],
        assetSampulPath: json["asset_sampul_path"],
        assetBukuPath: json["asset_buku_path"],
        judul: json["judul"],
        penulis: json["penulis"],
        tipe: json["tipe"],
      );

  Map<String, dynamic> toJson() => {
        "id_buku": idBuku,
        "id_user": idUser,
        "last_page_seen": lastPageSeen,
        "total_pages": totalPages,
        "expired": expired.toIso8601String(),
        "status": status,
        "asset_sampul_path": assetSampulPath,
        "asset_buku_path": assetBukuPath,
        "judul": judul,
        "penulis": penulis,
        "tipe": tipe,
      };
}
