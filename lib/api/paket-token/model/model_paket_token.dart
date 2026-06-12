num? _toNum(dynamic v) => v == null ? null : (v is num ? v : num.tryParse(v.toString()));

class PaketToken {
  final String? id;
  final String? nama;
  final int? harga;
  final num? jumlahToken;
  final int? tambahanMasaAktif;
  final String? deskripsi;

  PaketToken({
    this.id,
    this.nama,
    this.harga,
    this.jumlahToken,
    this.tambahanMasaAktif,
    this.deskripsi,
  });

  factory PaketToken.fromJson(Map<String, dynamic> json) => PaketToken(
        id: json["id"],
        nama: json["nama"],
        harga: _toNum(json["harga"])?.toInt(),
        jumlahToken: _toNum(json["jumlahToken"]),
        tambahanMasaAktif: _toNum(json["tambahanMasaAktif"])?.toInt(),
        deskripsi: json["deskripsi"],
      );
}

class PaketTokenList {
  final List<PaketToken> listPaketToken;

  PaketTokenList({required this.listPaketToken});

  factory PaketTokenList.fromJson(Map<String, dynamic> json) => PaketTokenList(
        listPaketToken: (((json["listPaketToken"] ?? []) as List))
            .map((e) => PaketToken.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
