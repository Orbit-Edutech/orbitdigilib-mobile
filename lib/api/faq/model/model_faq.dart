import 'dart:convert';

class ModelFaq {
  final List<FAQ>? listFaq;

  ModelFaq({
    this.listFaq,
  });

  ModelFaq copyWith({
    List<FAQ>? listFaq,
  }) =>
      ModelFaq(
        listFaq: listFaq ?? this.listFaq,
      );

  factory ModelFaq.fromRawJson(String str) => ModelFaq.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelFaq.fromJson(Map<String, dynamic> json) => ModelFaq(
        listFaq: json["listFAQ"] == null ? [] : List<FAQ>.from(json["listFAQ"]!.map((x) => FAQ.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "listFAQ": listFaq == null ? [] : List<dynamic>.from(listFaq!.map((x) => x.toJson())),
      };
}

class FAQ {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? pertanyaan;
  final String? jawaban;

  FAQ({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.pertanyaan,
    this.jawaban,
  });

  FAQ copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? pertanyaan,
    String? jawaban,
  }) =>
      FAQ(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        pertanyaan: pertanyaan ?? this.pertanyaan,
        jawaban: jawaban ?? this.jawaban,
      );

  factory FAQ.fromRawJson(String str) => FAQ.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FAQ.fromJson(Map<String, dynamic> json) => FAQ(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        pertanyaan: json["pertanyaan"],
        jawaban: json["jawaban"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "pertanyaan": pertanyaan,
        "jawaban": jawaban,
      };
}
