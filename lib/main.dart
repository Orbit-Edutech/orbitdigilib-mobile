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
  "name": "sewa.createOne | Create One Sewa",
  "type": "Success",
  "statusCode": 201,
  "result": {
    "id": "5ffbb6c8-54ee-4217-8684-09e18ef9813f",
    "createdAt": "2024-07-25T18:47:42.028Z",
    "updatedAt": "2024-07-25T18:47:42.028Z",
    "hargaSewa": 18,
    "tanggalSewa": "2024-07-25T18:47:42.054Z",
    "tanggalHabisSewa": "2024-08-08T18:47:42.054Z",
    "user": {
      "id": "5fb61c37-6882-40d7-b7db-d9d09df09765",
      "createdAt": "2024-03-25T07:13:02.238Z",
      "updatedAt": "2024-06-19T06:52:23.105Z",
      "username": "bimantara",
      "passwordUpdatedAt": "2024-03-28T03:08:30.035Z",
      "email": "bimantarats@gmail.com",
      "nama": "Bimantara Tirta Susila",
      "jenisKelamin": "Laki-Laki",
      "noTelepon": "087739774870",
      "urlFotoProfil": null,
      "tokenForgotPassword": "1abb1269dae9a329e6967c64c8b4bbf808a76d7fea4452283e35ad9cfa55998d",
      "tokenForgotPasswordExpiredAt": "2024-05-13T08:27:01.045Z",
      "token": "480.00",
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
      "id": "2c0c6026-094d-4d68-9f5a-956cefb875be",
      "createdAt": "2024-07-25T18:47:42.028Z",
      "updatedAt": "2024-07-25T18:47:42.028Z",
      "namaKategori": "Teknik",
      "namaPenerbit": "Badan Bahasa",
      "judul": "Guardians And Swindlers",
      "sinopsis": "-",
      "jumlahHalaman": 201,
      "tahunTerbit": "2015",
      "isbn": "",
      "eIsbn": "",
      "bahasa": "Bahasa Indonesia",
      "penulis": "Penulis 9, Penulis 10",
      "ilustrator": "",
      "assetSampulId": "6834d8e3-fb48-482f-8975-11941a07bc79",
      "assetBukuId": "638ce44a-4492-4270-9e27-0d57575a7d0f"
    }
  }
};
