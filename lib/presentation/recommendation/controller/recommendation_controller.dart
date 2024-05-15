import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../api/buku-perpustakaan/data/buku_perpustakaan_get_all.dart';
import '../../../api/buku-perpustakaan/model/model_all_buku_perpustakaan.dart';

class RecommendationController extends GetxController {
  final scrollController = ScrollController();
  final searchController = TextEditingController();
  final focusNode = FocusNode();
  CancelToken cancelToken = CancelToken();

  Rx<int> page = 2.obs;
  Rx<bool> asc = true.obs;
  Rx<bool> isLoadedMore = false.obs;
  Timer? _timer;

  Rx<List<Payload>?> books = Rx<List<Payload>?>(null);
  Rx<List<Payload>?> filteredBooks = Rx<List<Payload>?>(null);

  @override
  Future<void> onInit() async {
    books.value = Get.arguments;
    filteredBooks.value = books.value;
    scrollController.addListener(loadMore);
    super.onInit();
  }

  void onSearch(String keyword) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 250), () async {
      books.value = null;
      Map<String, dynamic> qp = {};
      qp["isPin"] = true;
      if (keyword.trim().isNotEmpty) {
        qp["buku[judul][lke]"] = keyword;
      }
      cancelToken.cancel();
      cancelToken = CancelToken();
      final response = await getAllBukuPerpustakaan(qp, cancelToken);
      if (response.data != null) {
        books.value = response.data?.payload?.where((book) => book.isVisible!).toList();
      }
    });
  }

  void sort() {
    books.value?.sort((a, b) {
      final hargaSewaTerendah = (a.buku?.hargaSewa ?? 0);
      final hargaSewaTertinggi = (b.buku?.hargaSewa ?? 0);
      return asc.value ? hargaSewaTerendah.compareTo(hargaSewaTertinggi) : hargaSewaTertinggi.compareTo(hargaSewaTerendah);
    });
    asc.value = !asc.value;
  }

  Future<void> loadMore() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoadedMore.value) {
      isLoadedMore.value = true;
      Map<String, dynamic> qp = {};
      final keyword = searchController.value.text;
      qp["isPin"] = true;
      if (keyword.trim().isNotEmpty) {
        qp["buku[judul][lke]"] = keyword;
      }
      qp["page"] = page.value;
      final response = await getAllBukuPerpustakaan(qp);
      if (response.data != null) {
        if (response.data!.payload?.isNotEmpty ?? false) {
          books.value?.addAll(response.data?.payload?.where((book) => book.isVisible!).toList() ?? []);
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
