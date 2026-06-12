num? _toNum(dynamic v) => v == null ? null : (v is num ? v : num.tryParse(v.toString()));

class Topup {
  final String? id;
  final String? status;
  final String? metode;
  final String? bankCode;
  final String? vaNumber;
  final String? qrString;
  final String? expiresAt;
  final int? harga;
  final num? jumlahToken;

  Topup({
    this.id,
    this.status,
    this.metode,
    this.bankCode,
    this.vaNumber,
    this.qrString,
    this.expiresAt,
    this.harga,
    this.jumlahToken,
  });

  factory Topup.fromJson(Map<String, dynamic> json) => Topup(
        id: json["id"],
        status: json["status"],
        metode: json["metode"],
        bankCode: json["bankCode"],
        vaNumber: json["vaNumber"],
        qrString: json["qrString"],
        expiresAt: json["expiresAt"],
        harga: _toNum(json["harga"])?.toInt(),
        jumlahToken: _toNum(json["jumlahToken"]),
      );
}
