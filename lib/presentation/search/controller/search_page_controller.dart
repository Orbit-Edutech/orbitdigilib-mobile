import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';

import '../../../api/buku-perpustakaan/data/buku_perpustakaan_get_all.dart';
import '../../../api/buku-perpustakaan/model/model_all_buku_perpustakaan.dart';
import '../../index/controller/index_controller.dart';

class SearchPageController extends GetxController {
  final perpustakaan = Get.find<IndexController>().perpustakaan.value;

  Rx<List<Payload>?> books = Rx<List<Payload>?>(null);
  CancelToken cancelToken = CancelToken();

  final scrollController = ScrollController();
  final textController = TextEditingController();
  final searchFocusNode = FocusNode();

  Rx<int> page = 2.obs;
  Rx<bool> isLoadedMore = false.obs;
  Rx<bool> isReversed = false.obs;
  Timer? _timer;

  @override
  Future<void> onInit() async {
    await search("");
    scrollController.addListener(loadMore);
    super.onInit();
  }

  void sortBooks() {
    books.value?.sort((a, b) {
      final hargaSewaTerendah = (a.buku?.hargaSewa ?? 0);
      final hargaSewaTertinggi = (b.buku?.hargaSewa ?? 0);
      return isReversed.value
          ? hargaSewaTerendah.compareTo(hargaSewaTertinggi)
          : hargaSewaTertinggi.compareTo(hargaSewaTerendah);
    });
    isReversed.value = !isReversed.value;
    update();
  }

  Future<void> search(String keyword) async {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 250), () async {
      Map<String, dynamic> qp = {};
      if (keyword.trim().isNotEmpty) {
        qp["buku[judul][lke]"] = keyword;
      }
      cancelToken.cancel();
      cancelToken = CancelToken();
      final response = await getAllBukuPerpustakaan(perpustakaan?.id ?? "", qp, cancelToken);
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
      final response = await getAllBukuPerpustakaan(perpustakaan?.id ?? "", qp);
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
}
