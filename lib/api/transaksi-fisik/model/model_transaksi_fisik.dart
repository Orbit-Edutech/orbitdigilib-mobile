import 'dart:convert';

class ModelAllTransaksiFisik {
  final int? totalAllData;
  final int? totalData;
  final int? limit;
  final int? totalPage;
  final int? currentPage;
  final int? lastPage;
  final dynamic nextPage;
  final dynamic previousPage;
  final List<TransaksiFisikItem>? payload;

  ModelAllTransaksiFisik({
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

  factory ModelAllTransaksiFisik.fromRawJson(String str) =>
      ModelAllTransaksiFisik.fromJson(json.decode(str));

  factory ModelAllTransaksiFisik.fromJson(Map<String, dynamic> json) =>
      ModelAllTransaksiFisik(
        totalAllData: json["totalAllData"],
        totalData: json["totalData"],
        limit: json["limit"],
        totalPage: json["totalPage"],
        currentPage: json["currentPage"],
        lastPage: json["lastPage"],
        nextPage: json["nextPage"],
        previousPage: json["previousPage"],
        payload: json["payload"] == null
            ? []
            : List<TransaksiFisikItem>.from(
                json["payload"]!.map((x) => TransaksiFisikItem.fromJson(x))),
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
        "payload": payload == null
            ? []
            : List<dynamic>.from(payload!.map((x) => x.toJson())),
      };
}

class AssetRef {
  final String? id;
  AssetRef({this.id});
  factory AssetRef.fromJson(Map<String, dynamic> json) => AssetRef(id: json["id"]);
  Map<String, dynamic> toJson() => {"id": id};
}

class BukuFisikItem {
  final String? judul;
  final String? penulis;
  final AssetRef? assetSampul;

  BukuFisikItem({this.judul, this.penulis, this.assetSampul});

  factory BukuFisikItem.fromJson(Map<String, dynamic> json) => BukuFisikItem(
        judul: json["judul"],
        penulis: json["penulis"],
        assetSampul: json["assetSampul"] == null ? null : AssetRef.fromJson(json["assetSampul"]),
      );

  Map<String, dynamic> toJson() => {
        "judul": judul,
        "penulis": penulis,
        "assetSampul": assetSampul?.toJson(),
      };
}

class TransaksiFisikItem {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userId;
  final String? bukuFisikId;
  final String? perpustakaanId;
  final DateTime? tanggalPinjam;
  final DateTime? tanggalKembali;
  final DateTime? tanggalDikembalikan;
  final String? status;
  final BukuFisikItem? bukuFisik;

  TransaksiFisikItem({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.bukuFisikId,
    this.perpustakaanId,
    this.tanggalPinjam,
    this.tanggalKembali,
    this.tanggalDikembalikan,
    this.status,
    this.bukuFisik,
  });

  bool get isDipinjam => status == 'DIPINJAM';

  bool get isAlmostDue {
    if (tanggalKembali == null || !isDipinjam) return false;
    final diff = tanggalKembali!.difference(DateTime.now()).inDays;
    return diff <= 3 && diff >= 0;
  }

  bool get isOverdue {
    if (tanggalKembali == null || !isDipinjam) return false;
    return DateTime.now().isAfter(tanggalKembali!);
  }

  factory TransaksiFisikItem.fromJson(Map<String, dynamic> json) =>
      TransaksiFisikItem(
        id: json["id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        userId: json["userId"],
        bukuFisikId: json["bukuFisikId"],
        perpustakaanId: json["perpustakaanId"],
        tanggalPinjam: json["tanggalPinjam"] == null
            ? null
            : DateTime.parse(json["tanggalPinjam"]),
        tanggalKembali: json["tanggalKembali"] == null
            ? null
            : DateTime.parse(json["tanggalKembali"]),
        tanggalDikembalikan: json["tanggalDikembalikan"] == null
            ? null
            : DateTime.parse(json["tanggalDikembalikan"]),
        status: json["status"],
        bukuFisik: json["bukuFisik"] == null
            ? null
            : BukuFisikItem.fromJson(json["bukuFisik"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "userId": userId,
        "bukuFisikId": bukuFisikId,
        "perpustakaanId": perpustakaanId,
        "tanggalPinjam": tanggalPinjam?.toIso8601String(),
        "tanggalKembali": tanggalKembali?.toIso8601String(),
        "tanggalDikembalikan": tanggalDikembalikan?.toIso8601String(),
        "status": status,
        "bukuFisik": bukuFisik?.toJson(),
      };
}
