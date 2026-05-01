import 'dart:convert';

class RingkasanBacaan {
  final int? totalBukuDibaca;
  final int? totalHalamanDibaca;
  final int? totalDurasiMembaca;
  final List<BukuRingkasan>? daftarBuku;

  RingkasanBacaan({
    this.totalBukuDibaca,
    this.totalHalamanDibaca,
    this.totalDurasiMembaca,
    this.daftarBuku,
  });

  factory RingkasanBacaan.fromRawJson(String str) =>
      RingkasanBacaan.fromJson(json.decode(str));

  factory RingkasanBacaan.fromJson(Map<String, dynamic> json) => RingkasanBacaan(
        totalBukuDibaca: json["totalBukuDibaca"],
        totalHalamanDibaca: json["totalHalamanDibaca"],
        totalDurasiMembaca: json["totalDurasiMembaca"],
        daftarBuku: json["daftarBuku"] == null
            ? []
            : List<BukuRingkasan>.from(
                json["daftarBuku"]!.map((x) => BukuRingkasan.fromJson(x))),
      );
}

class BukuRingkasan {
  final String? id;
  final String? judul;
  final String? penulis;
  final String? assetSampulId;
  final int? totalHalaman;
  final int? halamanDibaca;
  final int? persentase;
  final int? totalDurasi;
  final DateTime? terakhirDibaca;

  BukuRingkasan({
    this.id,
    this.judul,
    this.penulis,
    this.assetSampulId,
    this.totalHalaman,
    this.halamanDibaca,
    this.persentase,
    this.totalDurasi,
    this.terakhirDibaca,
  });

  factory BukuRingkasan.fromRawJson(String str) =>
      BukuRingkasan.fromJson(json.decode(str));

  factory BukuRingkasan.fromJson(Map<String, dynamic> json) => BukuRingkasan(
        id: json["id"],
        judul: json["judul"],
        penulis: json["penulis"],
        assetSampulId: json["assetSampulId"],
        totalHalaman: json["totalHalaman"],
        halamanDibaca: json["halamanDibaca"],
        persentase: json["persentase"],
        totalDurasi: json["totalDurasi"],
        terakhirDibaca: json["terakhirDibaca"] == null
            ? null
            : DateTime.parse(json["terakhirDibaca"]),
      );
}
