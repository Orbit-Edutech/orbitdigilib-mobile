import 'dart:convert';

class ModelAllBukuPerpustakaan {
  final int? totalAllData;
  final int? totalData;
  final int? limit;
  final int? totalPage;
  final int? currentPage;
  final int? lastPage;
  final dynamic nextPage;
  final dynamic previousPage;
  final List<Payload>? payload;

  ModelAllBukuPerpustakaan({
    this.totalAllData,
    this.totalData,
    this.limit,
    this.totalPage,
    this.currentPage,
    this.lastPage,
    this.nextPage,
    this.previousPage,
    this.payload,
  });

  ModelAllBukuPerpustakaan copyWith({
    int? totalAllData,
    int? totalData,
    int? limit,
    int? totalPage,
    int? currentPage,
    int? lastPage,
    dynamic nextPage,
    dynamic previousPage,
    List<Payload>? payload,
  }) =>
      ModelAllBukuPerpustakaan(
        totalAllData: totalAllData ?? this.totalAllData,
        totalData: totalData ?? this.totalData,
        limit: limit ?? this.limit,
        totalPage: totalPage ?? this.totalPage,
        currentPage: currentPage ?? this.currentPage,
        lastPage: lastPage ?? this.lastPage,
        nextPage: nextPage ?? this.nextPage,
        previousPage: previousPage ?? this.previousPage,
        payload: payload ?? this.payload,
      );

  factory ModelAllBukuPerpustakaan.fromRawJson(String str) => ModelAllBukuPerpustakaan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelAllBukuPerpustakaan.fromJson(Map<String, dynamic> json) => ModelAllBukuPerpustakaan(
        totalAllData: json["totalAllData"],
        totalData: json["totalData"],
        limit: json["limit"],
        totalPage: json["totalPage"],
        currentPage: json["currentPage"],
        lastPage: json["lastPage"],
        nextPage: json["nextPage"],
        previousPage: json["previousPage"],
        payload: json["payload"] == null ? [] : List<Payload>.from(json["payload"]!.map((x) => Payload.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalAllData": totalAllData,
        "totalData": totalData,
        "limit": limit,
        "totalPage": totalPage,
        "currentPage": currentPage,
        "lastPage": lastPage,
        "nextPage": nextPage,
        "previousPage": previousPage,
        "payload": payload == null ? [] : List<dynamic>.from(payload!.map((x) => x.toJson())),
      };
}

class Payload {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Buku? buku;
  final int? jumlahSoftCopy;
  final int? jumlahSiapPinjam;
  final bool? isPin;
  final dynamic kategoriBukuPerpustakaanId;
  final dynamic kategoriBukuPerpustakaan;

  Payload({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.buku,
    this.jumlahSoftCopy,
    this.jumlahSiapPinjam,
    this.isPin,
    this.kategoriBukuPerpustakaanId,
    this.kategoriBukuPerpustakaan,
  });

  Payload copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Buku? buku,
    int? jumlahSoftCopy,
    int? jumlahSiapPinjam,
    bool? isPin,
    dynamic kategoriBukuPerpustakaanId,
    dynamic kategoriBukuPerpustakaan,
  }) =>
      Payload(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        buku: buku ?? this.buku,
        jumlahSoftCopy: jumlahSoftCopy ?? this.jumlahSoftCopy,
        jumlahSiapPinjam: jumlahSiapPinjam ?? this.jumlahSiapPinjam,
        isPin: isPin ?? this.isPin,
        kategoriBukuPerpustakaanId: kategoriBukuPerpustakaanId ?? this.kategoriBukuPerpustakaanId,
        kategoriBukuPerpustakaan: kategoriBukuPerpustakaan ?? this.kategoriBukuPerpustakaan,
      );

  factory Payload.fromRawJson(String str) => Payload.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        buku: json["buku"] == null ? null : Buku.fromJson(json["buku"]),
        jumlahSoftCopy: json["jumlahSoftCopy"],
        jumlahSiapPinjam: json["jumlahSiapPinjam"],
        isPin: json["isPin"],
        kategoriBukuPerpustakaanId: json["kategoriBukuPerpustakaanId"],
        kategoriBukuPerpustakaan: json["kategoriBukuPerpustakaan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "buku": buku?.toJson(),
        "jumlahSoftCopy": jumlahSoftCopy,
        "jumlahSiapPinjam": jumlahSiapPinjam,
        "isPin": isPin,
        "kategoriBukuPerpustakaanId": kategoriBukuPerpustakaanId,
        "kategoriBukuPerpustakaan": kategoriBukuPerpustakaan,
      };
}

class Buku {
  final String? id;
  final String? judul;
  final int? jumlahHalaman;
  final String? tahunTerbit;
  final String? bahasa;
  final String? penulis;
  final String? hargaBeli;
  final String? hargaSewa;
  final String? assetSampulId;

  Buku({
    this.id,
    this.judul,
    this.jumlahHalaman,
    this.tahunTerbit,
    this.bahasa,
    this.penulis,
    this.hargaBeli,
    this.hargaSewa,
    this.assetSampulId,
  });

  Buku copyWith({
    String? id,
    String? judul,
    int? jumlahHalaman,
    String? tahunTerbit,
    String? bahasa,
    String? penulis,
    String? hargaBeli,
    String? hargaSewa,
    String? assetSampulId,
  }) =>
      Buku(
        id: id ?? this.id,
        judul: judul ?? this.judul,
        jumlahHalaman: jumlahHalaman ?? this.jumlahHalaman,
        tahunTerbit: tahunTerbit ?? this.tahunTerbit,
        bahasa: bahasa ?? this.bahasa,
        penulis: penulis ?? this.penulis,
        hargaBeli: hargaBeli ?? this.hargaBeli,
        hargaSewa: hargaSewa ?? this.hargaSewa,
        assetSampulId: assetSampulId ?? this.assetSampulId,
      );

  factory Buku.fromRawJson(String str) => Buku.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Buku.fromJson(Map<String, dynamic> json) => Buku(
        id: json["id"],
        judul: json["judul"],
        jumlahHalaman: json["jumlahHalaman"],
        tahunTerbit: json["tahunTerbit"],
        bahasa: json["bahasa"],
        penulis: json["penulis"],
        hargaBeli: json["hargaBeli"],
        hargaSewa: json["hargaSewa"],
        assetSampulId: json["assetSampulId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "jumlahHalaman": jumlahHalaman,
        "tahunTerbit": tahunTerbit,
        "bahasa": bahasa,
        "penulis": penulis,
        "hargaBeli": hargaBeli,
        "hargaSewa": hargaSewa,
        "assetSampulId": assetSampulId,
      };
}
