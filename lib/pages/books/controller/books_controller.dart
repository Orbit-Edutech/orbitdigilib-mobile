import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../api/api_client.dart';
import '../../../api/buku-perpustakaan/model/model_categories_books.dart';
import '../../../api/kategori-perpus/data/get_all_kategori_perpus.dart';
import '../../../api/kategori-perpus/model/model_kategori_perpus_all.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';
import '../widgets/books_category_filter.dart';

class BooksController extends GetxController {
  Rx<List<KategoriBukuPerpustakaan>?> categories = Rx<List<KategoriBukuPerpustakaan>?>(null);
  RxList<String> filters = RxList<String>([]);
  Rx<List<CategoriesBooks>> datas = Rx<List<CategoriesBooks>>([]);
  @override
  Future<void> onInit() async {
    categories.value = null;
    filters.value = [];
    datas.value = [];
    getAllKategoriPerpus().then((res) {
      if (res.data != null) {
        categories.value = res.data?.listKategoriBukuPerpustakaan;
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

  void filter(String filter) {
    filters.contains(filter) ? filters.remove(filter) : filters.add(filter);
  }
}
