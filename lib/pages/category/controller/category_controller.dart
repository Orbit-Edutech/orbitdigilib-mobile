import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../api/buku-perpustakaan/model/model_all_buku_perpustakaan.dart';
import '../../../api/katalog-perpus/model/model_katalog_perpus_all.dart';
import '../../../api/buku-perpustakaan/data/buku_perpustakaan_get_all.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';

class CategoryController extends GetxController {
  Rx<int> page = 2.obs;
  Timer? _timer;
  Rx<bool> asc = false.obs;
  Rx<bool> isLoadedMore = false.obs;

  final scrollController = ScrollController();
  final textController = TextEditingController();
  final focusNode = FocusNode();
  CancelToken cancelToken = CancelToken();

  Rx<List<Payload>?> books = Rx<List<Payload>?>(null);
  Rx<List<Payload>?> filteredBooks = Rx<List<Payload>?>(null);
  final KatalogBukuPerpustakaan category = Get.arguments;

  @override
  Future<void> onInit() async {
    Map<String, dynamic> qp = {"katalogBukuPerpustakaanId": category.id};
    final response = await getAllBukuPerpustakaan(qp);
    if (response.data != null) {
      books.value = response.data!.payload;
      filteredBooks.value = books.value;
    } else {
      showSnackbar(
        title: "Error: ${response.statusCode}",
        message: response.error['message'],
        backgroundColor: AppColor.red,
      );
    }
    scrollController.addListener(loadMore);
    super.onInit();
  }

  void sort() {
    filteredBooks.value?.sort((a, b) {
      final second = b.buku?.judul ?? "";
      final first = a.buku?.judul ?? "";
      return asc.value ? second.compareTo(first) : first.compareTo(second);
    });
    asc.value = !asc.value;
  }

  void onSearch(String keyword) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500), () async {
      books.value = null;
      Map<String, dynamic> qp = {};
      qp["kategoriBukuPerpustakaanId"] = category.id;
      if (keyword.trim().isNotEmpty) qp["buku[judul][lke]"] = keyword;
      cancelToken.cancel();
      cancelToken = CancelToken();
      final response = await getAllBukuPerpustakaan(qp, cancelToken);
      if (response.data != null) {
        books.value = response.data?.payload;
        filteredBooks.value = books.value;
      }
    });
  }

  Future<void> loadMore() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoadedMore.value) {
      isLoadedMore.value = true;
      Map<String, dynamic> qp = {};
      final keyword = textController.value.text;
      qp["kategoriBukuPerpustakaanId"] = category.id;
      if (keyword.trim().isNotEmpty) qp["buku[judul][lke]"] = keyword;
      qp["page"] = page.value;
      final response = await getAllBukuPerpustakaan(qp);
      if (response.data != null) {
        if (response.data!.payload?.isNotEmpty ?? false) {
          books.value?.addAll(response.data?.payload ?? []);
          final result = books.value;
          books.value = result;
          filteredBooks.value = books.value;
          page.value++;
        }
      }
      isLoadedMore.value = false;
    }
  }
}
