import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../api/buku-perpustakaan/data/buku_perpustakaan_get_all.dart';
import '../../../api/buku-perpustakaan/model/model_all_buku_perpustakaan.dart';

class SearchPageController extends GetxController {
  // TODO: Selesaikan Controller ini
  Rx<List<Payload>?> books = Rx<List<Payload>?>(null);
  CancelToken cancelToken = CancelToken();

  final textController = TextEditingController();
  final searchFocusNode = FocusNode();

  @override
  Future<void> onInit() async {
    await search("");
    super.onInit();
  }

  void sort() {}

  Future<void> search(String keyword) async {
    books.value = null;
    Map<String, dynamic> qp = {};
    if (keyword.isNotEmpty) qp["buku[judul]"] = keyword;
    cancelToken.cancel();
    cancelToken = CancelToken();
    final response = await getAllBukuPerpustakaan(qp, cancelToken);
    if (response.data != null) {
      books.value = response.data?.payload;
    }
  }
}
