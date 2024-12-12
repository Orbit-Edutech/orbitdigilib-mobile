import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../api/api_client.dart';
import '../../../api/buku-perpustakaan/data/buku_perpustakaan_get_all.dart';
import '../../../api/buku-perpustakaan/model/model_all_buku_perpustakaan.dart';
import '../../../api/hak-akses/data/get_all_access.dart';
import '../../../api/hak-akses/data/change_access.dart' as c;
import '../../../api/hak-akses/model/model_all_access.dart';
import '../../../api/katalog-perpus/data/get_all_katalog_perpus.dart';
import '../../../api/katalog-perpus/model/model_katalog_perpus_all.dart';
import '../../../api/perpustakaan/data/perpustakaan_get_banner_default.dart';
import '../../../api/perpustakaan/data/perpustakaan_get_one.dart';
import '../../../api/perpustakaan/model/model_perpustakaan.dart' as p;

import '../../../constants/sizes.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';
import '../../splash/controller/splash_controller.dart';
import '../widgets/index_categories_modal.dart';
import '../widgets/index_large_banner.dart';

class IndexController extends GetxController {
  final checkAccess = Get.find<SplashController>().checkAccess.value;

  final Rx<p.Perpustakaan?> perpustakaan = Rx<p.Perpustakaan?>(null);
  Rx<List<KatalogBukuPerpustakaan>?> categories = Rx<List<KatalogBukuPerpustakaan>?>(null);
  Rx<List<Payload>?> pinnedBooks = Rx<List<Payload>?>(null);
  Rx<List<Payload>?> allBooks = Rx<List<Payload>?>(null);
  Rx<List<Payload>?> promoBooks = Rx<List<Payload>?>(null);
  Rx<List<String>> banners = Rx<List<String>>([]);
  Rx<ModelAllAccess?> allAccess = Rx<ModelAllAccess?>(null);

  Rx<bool> isBalanceVisible = false.obs;
  Rx<bool> isLoadedMore = false.obs;
  Rx<int> promoPage = 1.obs;
  Rx<ButtonState> changeAccessState = ButtonState.enable.obs;
  final scrollController = ScrollController();
  final persistentController = PersistentTabController();

  @override
  Future onInit() async {
    perpustakaan.value = null;
    banners.value = [];
    pinnedBooks.value = null;
    allBooks.value = null;
    promoBooks.value = null;
    final kode = checkAccess?.perpustakaan?.kode ?? "";
    final id = checkAccess?.perpustakaan?.id ?? "";
    debugPrint(id.toString());
    await getBannerDefault(kode).then((res) {
      if (res.data != null) {
        final banners = <String>[];
        for (var banner in res.data!.listBanner!) {
          if (!this.banners.value.contains(banner.id)) {
            banners.add(banner.id!);
          }
        }
        this.banners.value = banners;
      } else {
        if (res.error == ResponseStatus.connectionError) {
          showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
        } else {
          showSnackbar(
            backgroundColor: AppColor.red,
            title: "Error ${res.statusCode}",
            message: res.error["message"] ?? "Terjadi Kesalahan",
          );
        }
      }
    });
    Future.wait([
      getAllAccess().then((res) {
        if (res.data != null) {
          allAccess.value = res.data;
        } else {
          if (res.error == ResponseStatus.connectionError) {
            showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
          } else {
            showSnackbar(backgroundColor: AppColor.red, title: "Error ${res.statusCode}", message: res.error["message"]);
          }
        }
      }),
      getOnePerpustakaan(kode).then((res) {
        if (res.data != null) {
          perpustakaan.value = res.data;
          final banners = this.banners.value;
          for (var banner in perpustakaan.value!.banner!) {
            if (!this.banners.value.contains(banner.id)) {
              banners.add(banner.id!);
            }
          }
          this.banners.value = banners;
          AppTheme.changePerpusTheme(perpustakaan.value!.warnaDasar);
        } else {
          if (res.error == ResponseStatus.connectionError) {
            showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
          } else {
            showSnackbar(backgroundColor: AppColor.red, title: "Error ${res.statusCode}", message: res.error["message"]);
          }
        }
      }),
      getAllBukuPerpustakaan(perpustakaan.value?.id ?? "", {"isPin": true}).then((res) {
        if (res.data != null) {
          pinnedBooks.value = res.data?.payload?.where((book) => book.isVisible!).toList();
        } else {
          pinnedBooks.value = [];
          if (res.error == ResponseStatus.connectionError) {
            showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
          } else {
            showSnackbar(backgroundColor: AppColor.red, title: "Error ${res.statusCode}", message: res.error["message"]);
          }
        }
      }),
      getAllBukuPerpustakaan(perpustakaan.value?.id ?? "", {"buku[promo][noteql]": "null"}).then((res) {
        if (res.data != null) {
          promoBooks.value = res.data?.payload?.where((book) => book.isVisible!).toList();
        } else {
          if (res.error == ResponseStatus.connectionError) {
            showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
          } else {
            showSnackbar(backgroundColor: AppColor.red, title: "Error ${res.statusCode}", message: res.error["message"]);
          }
        }
      }),
      getAllBukuPerpustakaan(
        perpustakaan.value?.id ?? "",
      ).then((res) {
        if (res.data != null) {
          allBooks.value = res.data?.payload?.where((book) => book.isVisible!).toList();
        } else {
          if (res.error == ResponseStatus.connectionError) {
            showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
          } else {
            showSnackbar(backgroundColor: AppColor.red, title: "Error ${res.statusCode}", message: res.error["message"]);
          }
        }
      }),
      getAllKatalogPerpus(perpustakaan.value?.id ?? "").then((res) {
        if (res.data != null) {
          categories.value = res.data?.listKatalogBukuPerpustakaan?.where((katalog) => katalog.deletedAt == null).toList();
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

  void showLargeBanner(List<String> banners, int index) {
    Get.dialog(
      LargeBanner(banners: banners, index: index),
      transitionDuration: const Duration(milliseconds: 100),
    );
  }

  void loadMorePromo() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoadedMore.value) {
      isLoadedMore.value = true;
      final response = await getAllBukuPerpustakaan(
          perpustakaan.value?.id ?? "", {"buku[promo][noteql]": "null", "page": promoPage.value});
      if (response.data != null) {
        if (response.data!.payload?.isNotEmpty ?? false) {
          promoBooks.value?.addAll(response.data?.payload?.where((book) => book.isVisible!).toList() ?? []);
          final result = promoBooks.value;
          promoBooks.value = result;
          promoPage.value++;
        }
      }
      isLoadedMore.value = false;
    }
  }

  void changeAccess(String perpustakaanId) async {
    changeAccessState.value = ButtonState.loading;
    final response = await c.changeAccess(perpustakaanId);
    if (response.data != null) {
      Get.offAllNamed(AppRoutes.splash);
      Get.find<SplashController>().onInit();
    } else {
      if (response.error == ResponseStatus.connectionError) {
        showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
      } else {
        showSnackbar(
          backgroundColor: AppColor.red,
          title: "Error ${response.statusCode}",
          message: response.error["message"],
        );
      }
    }
    changeAccessState.value = ButtonState.loading;
  }
}
