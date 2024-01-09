import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

import '../../../api/api_client.dart';
import '../../../api/buku-perpustakaan/data/buku_perpustakaan_get_all.dart';
import '../../../api/buku-perpustakaan/model/model_all_buku_perpustakaan.dart';
import '../../../api/kategori-perpus/data/get_all_kategori_perpus.dart';
import '../../../api/kategori-perpus/model/model_kategori_perpus_all.dart';
import '../../../api/perpustakaan/data/perpustakaan_get_one.dart';
import '../../../api/perpustakaan/model/model_perpustakaan.dart';

import '../../../constants/sizes.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';
import '../../../utils/shared_preferences_manager.dart';
import '../widgets/index_categories_modal.dart';

class IndexController extends GetxController {
  final Rx<Perpustakaan?> perpustakaan = Rx<Perpustakaan?>(null);
  // kategori-buku-perpustakaan
  Rx<List<KategoriBukuPerpustakaan>?> categories = Rx<List<KategoriBukuPerpustakaan>?>(null);
  // List<String> categories = [
  //   "agama",
  //   "anak",
  //   "budaya",
  //   "fiksi",
  //   "hankam",
  //   "hobby",
  //   "hukum",
  //   "humaniora",
  //   "kamus",
  //   "keluarga",
  //   "kesehatan",
  //   "ketrampilan-khusus",
  //   "komik",
  //   "lifestyle",
  //   "medis",
  //   "pendidikan",
  //   "politik",
  //   "psikologi",
  //   "sains",
  //   "sastra",
  //   "sejarah",
  //   "seni-design",
  //   "sosial",
  //   "teknik"
  // ];

  Rx<List<Payload>?> pinnedBooks = Rx<List<Payload>?>(null);
  Rx<List<Payload>?> allBooks = Rx<List<Payload>?>(null);

  Rx<bool> isBalanceVisible = false.obs;

  @override
  Future onInit() async {
    final kode = await SharedPreferencesManager.readPref("kodePerpustakaan");
    final id = await SharedPreferencesManager.readPref("idPerpustakaan");
    debugPrint(id.toString());
    Future.wait([
      getOnePerpustakaan(kode).then((res) {
        if (res.data != null) {
          perpustakaan.value = res.data;
        } else {
          if (res.error == ResponseStatus.connectionError) {
            showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
          } else {
            showSnackbar(backgroundColor: AppColor.red, title: "Error ${res.statusCode}", message: res.error["message"]);
          }
        }
      }),
      getAllBukuPerpustakaan({"isPin": true}).then((res) {
        if (res.data != null) {
          pinnedBooks.value = res.data?.payload;
        } else {
          if (res.error == ResponseStatus.connectionError) {
            showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
          } else {
            showSnackbar(backgroundColor: AppColor.red, title: "Error ${res.statusCode}", message: res.error["message"]);
          }
        }
      }),
      getAllBukuPerpustakaan().then((res) {
        if (res.data != null) {
          allBooks.value = res.data!.payload;
          log(res.data!.toRawJson());
        } else {
          if (res.error == ResponseStatus.connectionError) {
            showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
          } else {
            showSnackbar(backgroundColor: AppColor.red, title: "Error ${res.statusCode}", message: res.error["message"]);
          }
        }
      }),
      getAllKategoriPerpus().then((res) {
        if (res.data != null) {
          categories.value = res.data?.listKategoriBukuPerpustakaan;
          log(res.data!.toRawJson().toString());
        } else {
          if (res.error == ResponseStatus.connectionError) {
            showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
          } else {
            showSnackbar(backgroundColor: AppColor.red, title: "Error ${res.statusCode}", message: res.error["message"]);
          }
        }
      }),
    ]);
    super.onInit();
  }

  void showCategories() {
    Get.bottomSheet(
      IndexCategoriesModal(categories: categories.value ?? []),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.r)),
      ),
      isScrollControlled: true,
      enableDrag: false,
    );
  }
}
