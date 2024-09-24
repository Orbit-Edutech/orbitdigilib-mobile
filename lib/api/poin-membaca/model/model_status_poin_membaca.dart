import 'dart:convert';

class StatusPoinMembaca {
  Buku? buku;
  double? persentaseBacaBuku;
  int? totalHalaman;
  List<int>? halamanDibaca;
  int? jmlHalamanDibaca;
  List<int>? halamanBelumDibaca;
  int? jmlHalamanBelumDibaca;
  List<Detail>? detail;

  StatusPoinMembaca({
    this.buku,
    this.persentaseBacaBuku,
    this.totalHalaman,
    this.halamanDibaca,
    this.jmlHalamanDibaca,
    this.halamanBelumDibaca,
    this.jmlHalamanBelumDibaca,
    this.detail,
  });

  StatusPoinMembaca copyWith({
    Buku? buku,
    double? persentaseBacaBuku,
    int? totalHalaman,
    List<int>? halamanDibaca,
    int? jmlHalamanDibaca,
    List<int>? halamanBelumDibaca,
    int? jmlHalamanBelumDibaca,
    List<Detail>? detail,
  }) =>
      StatusPoinMembaca(
        buku: buku ?? this.buku,
        persentaseBacaBuku: persentaseBacaBuku ?? this.persentaseBacaBuku,
        totalHalaman: totalHalaman ?? this.totalHalaman,
        halamanDibaca: halamanDibaca ?? this.halamanDibaca,
        jmlHalamanDibaca: jmlHalamanDibaca ?? this.jmlHalamanDibaca,
        halamanBelumDibaca: halamanBelumDibaca ?? this.halamanBelumDibaca,
        jmlHalamanBelumDibaca: jmlHalamanBelumDibaca ?? this.jmlHalamanBelumDibaca,
        detail: detail ?? this.detail,
      );

  factory StatusPoinMembaca.fromRawJson(String str) => StatusPoinMembaca.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StatusPoinMembaca.fromJson(Map<String, dynamic> json) => StatusPoinMembaca(
        buku: json["buku"] == null ? null : Buku.fromJson(json["buku"]),
        persentaseBacaBuku: json["persentaseBacaBuku"]?.toDouble(),
        totalHalaman: json["totalHalaman"],
        halamanDibaca: json["halamanDibaca"] == null ? [] : List<int>.from(json["halamanDibaca"]!.map((x) => x)),
        jmlHalamanDibaca: json["jmlHalamanDibaca"],
        halamanBelumDibaca:
            json["halamanBelumDibaca"] == null ? [] : List<int>.from(json["halamanBelumDibaca"]!.map((x) => x)),
        jmlHalamanBelumDibaca: json["jmlHalamanBelumDibaca"],
        detail: json["detail"] == null ? [] : List<Detail>.from(json["detail"]!.map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "buku": buku?.toJson(),
        "persentaseBacaBuku": persentaseBacaBuku,
        "totalHalaman": totalHalaman,
        "halamanDibaca": halamanDibaca == null ? [] : List<dynamic>.from(halamanDibaca!.map((x) => x)),
        "jmlHalamanDibaca": jmlHalamanDibaca,
        "halamanBelumDibaca": halamanBelumDibaca == null ? [] : List<dynamic>.from(halamanBelumDibaca!.map((x) => x)),
        "jmlHalamanBelumDibaca": jmlHalamanBelumDibaca,
        "detail": detail == null ? [] : List<dynamic>.from(detail!.map((x) => x.toJson())),
      };
}

class Buku {
  String? id;
  String? judul;
  int? jumlahHalaman;
  String? tahunTerbit;
  String? penulis;
  int? hargaBeli;
  int? hargaSewa;
  dynamic namaPenerbitReal;
  bool? peringatan;
  dynamic keterangan;
  String? assetSampulId;
  dynamic promo;

  Buku({
    this.id,
    this.judul,
    this.jumlahHalaman,
    this.tahunTerbit,
    this.penulis,
    this.hargaBeli,
    this.hargaSewa,
    this.namaPenerbitReal,
    this.peringatan,
    this.keterangan,
    this.assetSampulId,
    this.promo,
  });

  Buku copyWith({
    String? id,
    String? judul,
    int? jumlahHalaman,
    String? tahunTerbit,
    String? penulis,
    int? hargaBeli,
    int? hargaSewa,
    dynamic namaPenerbitReal,
    bool? peringatan,
    dynamic keterangan,
    String? assetSampulId,
    dynamic promo,
  }) =>
      Buku(
        id: id ?? this.id,
        judul: judul ?? this.judul,
        jumlahHalaman: jumlahHalaman ?? this.jumlahHalaman,
        tahunTerbit: tahunTerbit ?? this.tahunTerbit,
        penulis: penulis ?? this.penulis,
        hargaBeli: hargaBeli ?? this.hargaBeli,
        hargaSewa: hargaSewa ?? this.hargaSewa,
        namaPenerbitReal: namaPenerbitReal ?? this.namaPenerbitReal,
        peringatan: peringatan ?? this.peringatan,
        keterangan: keterangan ?? this.keterangan,
        assetSampulId: assetSampulId ?? this.assetSampulId,
        promo: promo ?? this.promo,
      );

  factory Buku.fromRawJson(String str) => Buku.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Buku.fromJson(Map<String, dynamic> json) => Buku(
        id: json["id"],
        judul: json["judul"],
        jumlahHalaman: json["jumlahHalaman"],
        tahunTerbit: json["tahunTerbit"],
        penulis: json["penulis"],
        hargaBeli: json["hargaBeli"],
        hargaSewa: json["hargaSewa"],
        namaPenerbitReal: json["namaPenerbitReal"],
        peringatan: json["peringatan"],
        keterangan: json["keterangan"],
        assetSampulId: json["assetSampulId"],
        promo: json["promo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "jumlahHalaman": jumlahHalaman,
        "tahunTerbit": tahunTerbit,
        "penulis": penulis,
        "hargaBeli": hargaBeli,
        "hargaSewa": hargaSewa,
        "namaPenerbitReal": namaPenerbitReal,
        "peringatan": peringatan,
        "keterangan": keterangan,
        "assetSampulId": assetSampulId,
        "promo": promo,
      };
}

class Detail {
  int? halaman;
  List<int>? durasi;
  int? totalDurasi;
  bool? statusHalaman;

  Detail({
    this.halaman,
    this.durasi,
    this.totalDurasi,
    this.statusHalaman,
  });

  Detail copyWith({
    int? halaman,
    List<int>? durasi,
    int? totalDurasi,
    bool? statusHalaman,
  }) =>
      Detail(
        halaman: halaman ?? this.halaman,
        durasi: durasi ?? this.durasi,
        totalDurasi: totalDurasi ?? this.totalDurasi,
        statusHalaman: statusHalaman ?? this.statusHalaman,
      );

  factory Detail.fromRawJson(String str) => Detail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        halaman: json["halaman"],
        durasi: json["durasi"] == null ? [] : List<int>.from(json["durasi"]!.map((x) => x)),
        totalDurasi: json["totalDurasi"],
        statusHalaman: json["statusHalaman"],
      );

  Map<String, dynamic> toJson() => {
        "halaman": halaman,
        "durasi": durasi == null ? [] : List<dynamic>.from(durasi!.map((x) => x)),
        "totalDurasi": totalDurasi,
        "statusHalaman": statusHalaman,
      };
}
