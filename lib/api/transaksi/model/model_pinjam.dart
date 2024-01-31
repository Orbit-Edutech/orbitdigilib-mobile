import 'dart:convert';

class ModelPinjam {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? tanggalPinjam;
  final DateTime? tanggalKembali;
  final User? user;
  final BukuPerpust? bukuPerpust;

  ModelPinjam({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.tanggalPinjam,
    this.tanggalKembali,
    this.user,
    this.bukuPerpust,
  });

  ModelPinjam copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? tanggalPinjam,
    DateTime? tanggalKembali,
    User? user,
    BukuPerpust? bukuPerpust,
  }) =>
      ModelPinjam(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        tanggalPinjam: tanggalPinjam ?? this.tanggalPinjam,
        tanggalKembali: tanggalKembali ?? this.tanggalKembali,
        user: user ?? this.user,
        bukuPerpust: bukuPerpust ?? this.bukuPerpust,
      );

  factory ModelPinjam.fromRawJson(String str) => ModelPinjam.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ModelPinjam.fromJson(Map<String, dynamic> json) => ModelPinjam(
        id: json["id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        tanggalPinjam: json["tanggalPinjam"] == null ? null : DateTime.parse(json["tanggalPinjam"]),
        tanggalKembali: json["tanggalKembali"] == null ? null : DateTime.parse(json["tanggalKembali"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        bukuPerpust: json["bukuPerpust"] == null ? null : BukuPerpust.fromJson(json["bukuPerpust"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "tanggalPinjam": tanggalPinjam?.toIso8601String(),
        "tanggalKembali": tanggalKembali?.toIso8601String(),
        "user": user?.toJson(),
        "bukuPerpust": bukuPerpust?.toJson(),
      };
}

class BukuPerpust {
  final String? id;
  final int? jumlahSoftCopy;
  final int? jumlahSiapPinjam;
  final Perpustakaan? perpustakaan;
  final Buku? buku;
  final dynamic katalogBukuPerpustakaan;

  BukuPerpust({
    this.id,
    this.jumlahSoftCopy,
    this.jumlahSiapPinjam,
    this.perpustakaan,
    this.buku,
    this.katalogBukuPerpustakaan,
  });

  BukuPerpust copyWith({
    String? id,
    int? jumlahSoftCopy,
    int? jumlahSiapPinjam,
    Perpustakaan? perpustakaan,
    Buku? buku,
    dynamic katalogBukuPerpustakaan,
  }) =>
      BukuPerpust(
        id: id ?? this.id,
        jumlahSoftCopy: jumlahSoftCopy ?? this.jumlahSoftCopy,
        jumlahSiapPinjam: jumlahSiapPinjam ?? this.jumlahSiapPinjam,
        perpustakaan: perpustakaan ?? this.perpustakaan,
        buku: buku ?? this.buku,
        katalogBukuPerpustakaan: katalogBukuPerpustakaan ?? this.katalogBukuPerpustakaan,
      );

  factory BukuPerpust.fromRawJson(String str) => BukuPerpust.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BukuPerpust.fromJson(Map<String, dynamic> json) => BukuPerpust(
        id: json["id"],
        jumlahSoftCopy: json["jumlahSoftCopy"],
        jumlahSiapPinjam: json["jumlahSiapPinjam"],
        perpustakaan: json["perpustakaan"] == null ? null : Perpustakaan.fromJson(json["perpustakaan"]),
        buku: json["buku"] == null ? null : Buku.fromJson(json["buku"]),
        katalogBukuPerpustakaan: json["katalogBukuPerpustakaan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "jumlahSoftCopy": jumlahSoftCopy,
        "jumlahSiapPinjam": jumlahSiapPinjam,
        "perpustakaan": perpustakaan?.toJson(),
        "buku": buku?.toJson(),
        "katalogBukuPerpustakaan": katalogBukuPerpustakaan,
      };
}

class Buku {
  final String? id;
  final String? judul;
  final int? jumlahHalaman;
  final String? tahunTerbit;
  final String? penulis;
  final int? hargaBeli;
  final int? hargaSewa;
  final Bahasa? bahasa;
  final String? assetSampulId;

  Buku({
    this.id,
    this.judul,
    this.jumlahHalaman,
    this.tahunTerbit,
    this.penulis,
    this.hargaBeli,
    this.hargaSewa,
    this.bahasa,
    this.assetSampulId,
  });

  Buku copyWith({
    String? id,
    String? judul,
    int? jumlahHalaman,
    String? tahunTerbit,
    String? penulis,
    int? hargaBeli,
    int? hargaSewa,
    Bahasa? bahasa,
    String? assetSampulId,
  }) =>
      Buku(
        id: id ?? this.id,
        judul: judul ?? this.judul,
        jumlahHalaman: jumlahHalaman ?? this.jumlahHalaman,
        tahunTerbit: tahunTerbit ?? this.tahunTerbit,
        penulis: penulis ?? this.penulis,
        hargaBeli: hargaBeli ?? this.hargaBeli,
        hargaSewa: hargaSewa ?? this.hargaSewa,
        bahasa: bahasa ?? this.bahasa,
        assetSampulId: assetSampulId ?? this.assetSampulId,
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
        bahasa: json["bahasa"] == null ? null : Bahasa.fromJson(json["bahasa"]),
        assetSampulId: json["assetSampulId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "jumlahHalaman": jumlahHalaman,
        "tahunTerbit": tahunTerbit,
        "penulis": penulis,
        "hargaBeli": hargaBeli,
        "hargaSewa": hargaSewa,
        "bahasa": bahasa?.toJson(),
        "assetSampulId": assetSampulId,
      };
}

class Bahasa {
  final String? id;
  final String? bahasaResmi;
  final String? negara;
  final dynamic deletedAt;

  Bahasa({
    this.id,
    this.bahasaResmi,
    this.negara,
    this.deletedAt,
  });

  Bahasa copyWith({
    String? id,
    String? bahasaResmi,
    String? negara,
    dynamic deletedAt,
  }) =>
      Bahasa(
        id: id ?? this.id,
        bahasaResmi: bahasaResmi ?? this.bahasaResmi,
        negara: negara ?? this.negara,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  factory Bahasa.fromRawJson(String str) => Bahasa.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bahasa.fromJson(Map<String, dynamic> json) => Bahasa(
        id: json["id"],
        bahasaResmi: json["bahasaResmi"],
        negara: json["negara"],
        deletedAt: json["deletedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bahasaResmi": bahasaResmi,
        "negara": negara,
        "deletedAt": deletedAt,
      };
}

class Perpustakaan {
  final String? id;
  final String? nama;
  final String? deskripsi;
  final String? noTelepon;
  final int? tahunBerdiri;
  final String? warnaDasar;
  final String? namaPic;
  final String? contactPersonPic;

  Perpustakaan({
    this.id,
    this.nama,
    this.deskripsi,
    this.noTelepon,
    this.tahunBerdiri,
    this.warnaDasar,
    this.namaPic,
    this.contactPersonPic,
  });

  Perpustakaan copyWith({
    String? id,
    String? nama,
    String? deskripsi,
    String? noTelepon,
    int? tahunBerdiri,
    String? warnaDasar,
    String? namaPic,
    String? contactPersonPic,
  }) =>
      Perpustakaan(
        id: id ?? this.id,
        nama: nama ?? this.nama,
        deskripsi: deskripsi ?? this.deskripsi,
        noTelepon: noTelepon ?? this.noTelepon,
        tahunBerdiri: tahunBerdiri ?? this.tahunBerdiri,
        warnaDasar: warnaDasar ?? this.warnaDasar,
        namaPic: namaPic ?? this.namaPic,
        contactPersonPic: contactPersonPic ?? this.contactPersonPic,
      );

  factory Perpustakaan.fromRawJson(String str) => Perpustakaan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Perpustakaan.fromJson(Map<String, dynamic> json) => Perpustakaan(
        id: json["id"],
        nama: json["nama"],
        deskripsi: json["deskripsi"],
        noTelepon: json["noTelepon"],
        tahunBerdiri: json["tahunBerdiri"],
        warnaDasar: json["warnaDasar"],
        namaPic: json["namaPIC"],
        contactPersonPic: json["contactPersonPIC"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "deskripsi": deskripsi,
        "noTelepon": noTelepon,
        "tahunBerdiri": tahunBerdiri,
        "warnaDasar": warnaDasar,
        "namaPIC": namaPic,
        "contactPersonPIC": contactPersonPic,
      };
}

class User {
  final String? id;
  final String? username;
  final dynamic passwordUpdatedAt;
  final String? email;
  final String? nama;
  final String? jenisKelamin;
  final dynamic noTelepon;
  final dynamic urlFotoProfil;
  final dynamic tokenForgotPassword;
  final dynamic tokenForgotPasswordExpiredAt;
  final String? token;
  final Role? role;

  User({
    this.id,
    this.username,
    this.passwordUpdatedAt,
    this.email,
    this.nama,
    this.jenisKelamin,
    this.noTelepon,
    this.urlFotoProfil,
    this.tokenForgotPassword,
    this.tokenForgotPasswordExpiredAt,
    this.token,
    this.role,
  });

  User copyWith({
    String? id,
    String? username,
    dynamic passwordUpdatedAt,
    String? email,
    String? nama,
    String? jenisKelamin,
    dynamic noTelepon,
    dynamic urlFotoProfil,
    dynamic tokenForgotPassword,
    dynamic tokenForgotPasswordExpiredAt,
    String? token,
    Role? role,
  }) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        passwordUpdatedAt: passwordUpdatedAt ?? this.passwordUpdatedAt,
        email: email ?? this.email,
        nama: nama ?? this.nama,
        jenisKelamin: jenisKelamin ?? this.jenisKelamin,
        noTelepon: noTelepon ?? this.noTelepon,
        urlFotoProfil: urlFotoProfil ?? this.urlFotoProfil,
        tokenForgotPassword: tokenForgotPassword ?? this.tokenForgotPassword,
        tokenForgotPasswordExpiredAt: tokenForgotPasswordExpiredAt ?? this.tokenForgotPasswordExpiredAt,
        token: token ?? this.token,
        role: role ?? this.role,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        passwordUpdatedAt: json["passwordUpdatedAt"],
        email: json["email"],
        nama: json["nama"],
        jenisKelamin: json["jenisKelamin"],
        noTelepon: json["noTelepon"],
        urlFotoProfil: json["urlFotoProfil"],
        tokenForgotPassword: json["tokenForgotPassword"],
        tokenForgotPasswordExpiredAt: json["tokenForgotPasswordExpiredAt"],
        token: json["token"],
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "passwordUpdatedAt": passwordUpdatedAt,
        "email": email,
        "nama": nama,
        "jenisKelamin": jenisKelamin,
        "noTelepon": noTelepon,
        "urlFotoProfil": urlFotoProfil,
        "tokenForgotPassword": tokenForgotPassword,
        "tokenForgotPasswordExpiredAt": tokenForgotPasswordExpiredAt,
        "token": token,
        "role": role?.toJson(),
      };
}

class Role {
  final String? nama;

  Role({
    this.nama,
  });

  Role copyWith({
    String? nama,
  }) =>
      Role(
        nama: nama ?? this.nama,
      );

  factory Role.fromRawJson(String str) => Role.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        nama: json["nama"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
      };
}
