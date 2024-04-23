import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../api/api_client.dart';
import '../../../api/katalog-perpus/data/get_all_katalog_perpus.dart';
import '../../../api/katalog-perpus/model/model_katalog_perpus_all.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';
import '../widgets/books_category_filter.dart';

class BooksController extends GetxController {
  Rx<List<KatalogBukuPerpustakaan>?> categories = Rx<List<KatalogBukuPerpustakaan>?>(null);
  Rx<List<KatalogBukuPerpustakaan>?> filteredCategories = Rx<List<KatalogBukuPerpustakaan>?>(null);
  @override
  Future<void> onInit() async {
    categories.value = null;
    filteredCategories.value = [];
    getAllKatalogPerpus().then((res) {
      if (res.data != null) {
        categories.value = res.data?.listKatalogBukuPerpustakaan?.where((katalog) => katalog.deletedAt == null).toList();
        filteredCategories.value =
            res.data?.listKatalogBukuPerpustakaan?.where((katalog) => katalog.deletedAt == null).toList();
        filteredCategories.value!.add(KatalogBukuPerpustakaan(nama: "Lainnya", id: "Lainnya"));
      } else {
        if (res.error == ResponseStatus.connectionError) {
          showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
        } else {
          showSnackbar(backgroundColor: AppColor.red, title: "Error ${res.statusCode}", message: res.error["message"]);
        }
      }
    });
    super.onInit();
  }

  void showFilter() {
    Get.bottomSheet(
      const BooksCategoryFilter(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.r)),
      ),
      isScrollControlled: true,
      enableDrag: false,
    );
  }
}
