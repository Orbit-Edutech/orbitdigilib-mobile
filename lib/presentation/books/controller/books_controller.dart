import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../api/api_client.dart';
import '../../../api/buku-perpustakaan/data/buku_perpustakaan_get_all.dart';
import '../../../api/buku-perpustakaan/model/model_all_buku_perpustakaan.dart';
import '../../../api/katalog-perpus/data/get_all_katalog_perpus.dart';
import '../../../api/katalog-perpus/model/model_katalog_perpus_all.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';
import '../widgets/books_category_filter.dart';

class BooksController extends GetxController {
  Rx<List<KatalogBukuPerpustakaan>?> categories = Rx<List<KatalogBukuPerpustakaan>?>(null);
  Rx<KatalogBukuPerpustakaan?> category = Rx<KatalogBukuPerpustakaan?>(null);
  Rx<List<Payload>?> books = Rx<List<Payload>?>(null);
  CancelToken cancelToken = CancelToken();

  final scrollController = ScrollController();
  final textController = TextEditingController();
  final searchFocusNode = FocusNode();

  Rx<bool> isOnSearch = false.obs;
  Rx<int> page = 2.obs;
  Rx<bool> isLoadedMore = false.obs;
  Rx<bool> isReversed = false.obs;
  Timer? _timer;

  @override
  Future<void> onInit() async {
    await search("");
    categories.value = null;
    category.value = null;
    getAllKatalogPerpus().then((res) {
      if (res.data != null) {
        categories.value = res.data?.listKatalogBukuPerpustakaan?.where((katalog) => katalog.deletedAt == null).toList();
      } else {
        if (res.error == ResponseStatus.connectionError) {
          showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
        } else {
          showSnackbar(backgroundColor: AppColor.red, title: "Error ${res.statusCode}", message: res.error["message"]);
        }
      }
    });
    scrollController.removeListener(loadMore);
    scrollController.addListener(loadMore);
    super.onInit();
  }

  void onSearch() {
    isOnSearch.value = !isOnSearch.value;
  }

  Future<void> search(String keyword) async {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(Duration(milliseconds: keyword.isEmpty ? 0 : 250), () async {
      books.value = null;
      Map<String, dynamic> qp = {};
      if (keyword.trim().isNotEmpty) {
        qp["buku[judul][lke]"] = keyword;
      }
      if (category.value != null) {
        qp["katalogBukuPerpustakaanId"] = category.value?.id;
      }
      cancelToken.cancel();
      cancelToken = CancelToken();
      final response = await getAllBukuPerpustakaan(qp, cancelToken);
      if (response.data != null) {
        books.value = response.data!.payload?.where((book) => book.isVisible!).toList() ?? [];
      }
      update();
    });
  }

  Future<void> loadMore() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoadedMore.value) {
      isLoadedMore.value = true;
      Map<String, dynamic> qp = {};
      final keyword = textController.value.text;
      if (keyword.trim().isNotEmpty) {
        qp["buku[judul][lke]"] = keyword;
      }
      qp["page"] = page.value;
      final response = await getAllBukuPerpustakaan(qp);
      if (response.data != null) {
        if (response.data!.payload?.isNotEmpty ?? false) {
          books.value?.addAll(response.data?.payload?.where((book) => book.isVisible!).toList() ?? []);
          page.value++;
          update();
        }
      }
      isLoadedMore.value = false;
    }
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

  void changeCategory(KatalogBukuPerpustakaan? category) {
    this.category.value = category;
    search(textController.text);
  }
}
