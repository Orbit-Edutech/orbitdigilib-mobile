import 'dart:convert';

class ModelBukuSql {
  final String idBuku;
  final String idUser;
  final int lastPageSeen;
  final int totalPages;
  final DateTime expired;
  final String status;

  ModelBukuSql({
    required this.idBuku,
    required this.idUser,
    required this.lastPageSeen,
    required this.totalPages,
    required this.expired,
    required this.status,
  });

  ModelBukuSql copyWith({
    String? id,
    String? idBuku,
    String? idUser,
    int? lastPageSeen,
    int? totalPages,
    DateTime? expired,
    String? status,
  }) =>
      ModelBukuSql(
        idBuku: idBuku ?? this.idBuku,
        idUser: idUser ?? this.idUser,
        lastPageSeen: lastPageSeen ?? this.lastPageSeen,
        totalPages: totalPages ?? this.totalPages,
        expired: expired ?? this.expired,
        status: status ?? this.status,
      );

  factory ModelBukuSql.fromRawJson(String str) => ModelBukuSql.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelBukuSql.fromJson(Map<String, Object?> json) => ModelBukuSql(
        idBuku: json["id_buku"].toString(),
        idUser: json["id_user"].toString(),
        lastPageSeen: int.parse(json["last_page_seen"].toString()),
        totalPages: int.parse(json["total_pages"].toString()),
        expired: DateTime.parse(json["expired"].toString()),
        status: json["status"].toString(),
      );

  Map<String, Object?> toJson() => {
        "id_buku": idBuku,
        "id_user": idUser,
        "last_page_seen": lastPageSeen,
        "total_pages": totalPages,
        "expired": expired.toIso8601String(),
        "status": status,
      };
}
