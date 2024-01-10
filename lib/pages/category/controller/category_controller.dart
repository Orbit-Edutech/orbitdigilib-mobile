import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../api/buku-perpustakaan/model/model_all_buku_perpustakaan.dart';
import '../../../api/kategori-perpus/model/model_kategori_perpus_all.dart';
import '../../../api/buku-perpustakaan/data/buku_perpustakaan_get_all.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';

class CategoryController extends GetxController {
  Timer? _timer;
  Rx<bool> asc = false.obs;

  final textController = TextEditingController();
  final focusNode = FocusNode();

  Rx<List<Payload>?> books = Rx<List<Payload>?>(null);
  Rx<List<Payload>?> filteredBooks = Rx<List<Payload>?>(null);

  @override
  Future<void> onInit() async {
    final KategoriBukuPerpustakaan category = Get.arguments;
    final qp = {"kategoriBukuPerpustakaanId": category.id};
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

  void onSearch(String text) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 250), () {
      bool isOnSearch = text != "";
      filteredBooks.value = books.value?.where((wishlist) {
        final String judul = (wishlist.buku?.judul ?? "").toLowerCase();
        final String keyword = text.toLowerCase();
        bool searchedItem = judul.contains(keyword);
        return isOnSearch ? searchedItem : true;
      }).toList();
    });
  }
}
