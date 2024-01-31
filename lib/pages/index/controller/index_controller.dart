import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

import '../../../api/api_client.dart';
import '../../../api/buku-perpustakaan/data/buku_perpustakaan_get_all.dart';
import '../../../api/buku-perpustakaan/model/model_all_buku_perpustakaan.dart';
import '../../../api/katalog-perpus/data/get_all_katalog_perpus.dart';
import '../../../api/katalog-perpus/model/model_katalog_perpus_all.dart';
import '../../../api/perpustakaan/data/perpustakaan_get_one.dart';
import '../../../api/perpustakaan/model/model_perpustakaan.dart';

import '../../../constants/sizes.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';
import '../../../utils/shared_preferences_manager.dart';
import '../widgets/index_categories_modal.dart';
import '../widgets/index_large_banner.dart';

class IndexController extends GetxController {
  final Rx<Perpustakaan?> perpustakaan = Rx<Perpustakaan?>(null);
  Rx<List<KatalogBukuPerpustakaan>?> categories = Rx<List<KatalogBukuPerpustakaan>?>(null);
  Rx<List<Payload>?> pinnedBooks = Rx<List<Payload>?>(null);
  Rx<List<Payload>?> allBooks = Rx<List<Payload>?>(null);
  Rx<List<Payload>?> promoBooks = Rx<List<Payload>?>(null);

  Rx<bool> isBalanceVisible = false.obs;
  Rx<bool> isLoadedMore = false.obs;
  Rx<int> promoPage = 1.obs;
  final scrollController = ScrollController();

  @override
  Future onInit() async {
    perpustakaan.value = null;
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
      getAllBukuPerpustakaan({"buku[promo][noteql]": "null"}).then((res) {
        if (res.data != null) {
          promoBooks.value = res.data?.payload;
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
        } else {
          if (res.error == ResponseStatus.connectionError) {
            showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
          } else {
            showSnackbar(backgroundColor: AppColor.red, title: "Error ${res.statusCode}", message: res.error["message"]);
          }
        }
      }),
      getAllKatalogPerpus().then((res) {
        if (res.data != null) {
          categories.value = res.data?.listKatalogBukuPerpustakaan;
        } else {
          if (res.error == ResponseStatus.connectionError) {
            showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
          } else {
            showSnackbar(backgroundColor: AppColor.red, title: "Error ${res.statusCode}", message: res.error["message"]);
          }
        }
      }),
    ]);
    scrollController.addListener(loadMorePromo);
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

  void showLargeBanner(String bannerId) {
    Get.dialog(
      LargeBanner(bannerId: bannerId),
      transitionDuration: const Duration(milliseconds: 100),
    );
  }

  void loadMorePromo() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoadedMore.value) {
      isLoadedMore.value = true;
      final response = await getAllBukuPerpustakaan({"buku[promo][noteql]": "null", "page": promoPage.value});
      if (response.data != null) {
        if (response.data!.payload?.isNotEmpty ?? false) {
          promoBooks.value?.addAll(response.data?.payload ?? []);
          final result = promoBooks.value;
          promoBooks.value = result;
          promoPage.value++;
        }
      }
      isLoadedMore.value = false;
    }
  }
}
