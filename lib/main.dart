import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/app_info.dart';
import 'routes/app_bindings.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'utils/image_utils.dart';

void main() async {
  runApp(const MyApp());
  ImageUtils.prechacheImages();
}

// TODO:
// Update response dari backend (koleksi, sewa, beli, durasi membaca)
// Offline Mode
//  - Change theme sesuai sekolah dia
//  - Sinkronkan model local books dengan model remote books
//  - Bikin opsi untuk pindah ke online mode -> jika ada koneksi internet

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppInfo.name,
      theme: AppTheme.theme,
      themeMode: ThemeMode.light,
      initialBinding: AppBindings(),
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.splash,
    );
  }
}

var a = {
  "name": "beli.createOne | Create One",
  "type": "Success",
  "statusCode": 201,
  "result": {
    "id": "218529fc-f578-4bfe-be14-8edd7634c311",
    "createdAt": "2024-07-25T18:51:10.657Z",
    "updatedAt": "2024-07-25T18:51:10.657Z",
    "hargaBeli": 0,
    "user": {
      "id": "5fb61c37-6882-40d7-b7db-d9d09df09765",
      "createdAt": "2024-03-25T07:13:02.238Z",
      "updatedAt": "2024-07-25T18:47:42.028Z",
      "username": "bimantara",
      "passwordUpdatedAt": "2024-03-28T03:08:30.035Z",
      "email": "bimantarats@gmail.com",
      "nama": "Bimantara Tirta Susila",
      "jenisKelamin": "Laki-Laki",
      "noTelepon": "087739774870",
      "urlFotoProfil": null,
      "tokenForgotPassword": "1abb1269dae9a329e6967c64c8b4bbf808a76d7fea4452283e35ad9cfa55998d",
      "tokenForgotPasswordExpiredAt": "2024-05-13T08:27:01.045Z",
      "token": "462.00",
      "role": {"nama": "Anggota"},
      "perpustakaan": {
        "id": "9b38e44e-544e-42d3-8801-7c378532ded5",
        "createdAt": "2024-03-25T06:42:09.401Z",
        "updatedAt": "2024-07-24T20:20:08.227Z",
        "nama": "PERPUSTAKAAN ORBIT",
        "kode": "ORBIT360",
        "noTelepon": "+62161400360",
        "deskripsi": null,
        "tahunBerdiri": "2021",
        "warnaDasar": "Teal",
        "email": "info@orbit360.id",
        "namaPIC": "Muhammad Andy Zaky",
        "contactPersonPIC": "+621235646",
        "NPSN": "20210360",
        "isAktif": true
      },
      "penerbit": null,
      "isAktif": true
    },
    "bukuAnggota": {
      "id": "2b4f6954-d677-45dd-8123-849733aa4bff",
      "createdAt": "2024-07-25T18:51:10.657Z",
      "updatedAt": "2024-07-25T18:51:10.657Z",
      "namaKategori": "Komik",
      "namaPenerbit": "Badan Bahasa",
      "judul": "Ancaman di Desa Bersinar Jaya",
      "sinopsis":
          "Penyusun : Ignatus Yoshua, Ardi Timbul, Marhendi Wijaya W, Ika Setyawati\r\nTahun : 2021\r\nPenerbit : Ditjen Informasi dan komunikasi Publik Kominfo\r\n\r\nWarga Desa Bersinar Jaya gempar ketika sekumpulan monster aneh dan seram tiba-tiba menyerang desa mereka. Warga tidak bisa lari menyelematkan diri karena desa mereka sudah terkepung. Monster-monsteri itu memperkenalkan diri mereka sebagai Monster Candu dengan Molly Si Ratu Party sebagai pentolannya. Monster Narkoba ini mengajak warga untuk \"bersenang-senang\" sejenak, namun kemudian kesenangan itu harus dibayar mahal karena perlahan-lahan Narkoba merusak organ tubuh mereka yang berakhir overdosis dan beresiko menyebabkan kematian.",
      "jumlahHalaman": 32,
      "tahunTerbit": "2021",
      "isbn": "",
      "eIsbn": "",
      "bahasa": "Bahasa Indonesia",
      "penulis": "Ignatus Yoshua Ardi Timbul  Marhendi W. W. Ika S.",
      "ilustrator": "Ermambang B. Wijaya",
      "assetSampulId": "302d4499-6b12-4973-bc01-9b16cbf35e90",
      "assetBukuId": "a5f19210-ba6e-4a62-8d74-bad29be892e5"
    }
  }
};
