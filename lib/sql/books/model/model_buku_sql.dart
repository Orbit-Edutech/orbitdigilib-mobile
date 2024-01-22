import 'dart:convert';

class ModelBukuSql {
  final String idBuku;
  final String idUser;
  final int lastPageSeen;
  final int totalPages;
  final String status;

  ModelBukuSql({
    required this.idBuku,
    required this.idUser,
    required this.lastPageSeen,
    required this.totalPages,
    required this.status,
  });

  ModelBukuSql copyWith({
    String? idBuku,
    String? idUser,
    int? lastPageSeen,
    int? totalPages,
    String? status,
  }) =>
      ModelBukuSql(
        idBuku: idBuku ?? this.idBuku,
        idUser: idUser ?? this.idUser,
        lastPageSeen: lastPageSeen ?? this.lastPageSeen,
        totalPages: totalPages ?? this.totalPages,
        status: status ?? this.status,
      );

  factory ModelBukuSql.fromRawJson(String str) => ModelBukuSql.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelBukuSql.fromJson(Map<String, Object> json) => ModelBukuSql(
        idBuku: json["id_buku"].toString(),
        idUser: json["id_user"].toString(),
        lastPageSeen: int.parse(json["last_page_seen"].toString()),
        totalPages: int.parse(json["total_pages"].toString()),
        status: json["status"].toString(),
      );

  Map<String, Object> toJson() => {
        "id_buku": idBuku,
        "id_user": idUser,
        "last_page_seen": lastPageSeen,
        "total_pages": totalPages,
        "status": status,
      };
}
