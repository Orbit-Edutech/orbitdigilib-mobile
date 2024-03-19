import 'dart:convert';

class ModelStaredPagesSql {
  final int? id;
  final String? idBuku;
  final String? idUser;
  final int? halaman;

  ModelStaredPagesSql({
    this.id,
    this.idBuku,
    this.idUser,
    this.halaman,
  });

  ModelStaredPagesSql copyWith({
    int? id,
    String? idBuku,
    String? idUser,
    int? halaman,
  }) =>
      ModelStaredPagesSql(
        id: id ?? this.id,
        idBuku: idBuku ?? this.idBuku,
        idUser: idUser ?? this.idUser,
        halaman: halaman ?? this.halaman,
      );

  factory ModelStaredPagesSql.fromRawJson(String str) => ModelStaredPagesSql.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelStaredPagesSql.fromJson(Map<String, dynamic> json) => ModelStaredPagesSql(
        id: json["id"],
        idBuku: json["id_buku"],
        idUser: json["id_user"],
        halaman: json["halaman"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_buku": idBuku,
        "id_user": idUser,
        "halaman": halaman,
      };
}
