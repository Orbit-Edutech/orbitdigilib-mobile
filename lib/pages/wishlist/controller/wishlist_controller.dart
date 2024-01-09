import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../api/wishlist/data/wishlist_get_all.dart';
import '../../../api/wishlist/model/model_wishlist_all.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';

class WishlistController extends GetxController {
  Timer? _timer;
  Rx<bool> asc = false.obs;

  final textController = TextEditingController();
  final focusNode = FocusNode();

  Rx<List<Wishlist>?> wishlist = Rx<List<Wishlist>?>(null);
  Rx<List<Wishlist>?> filteredWishlist = Rx<List<Wishlist>?>(null);

  @override
  Future onInit() async {
    wishlist.value == null;
    filteredWishlist.value == null;
    textController.clear();
    final response = await getAllWishlist();
    if (response.data != null) {
      wishlist.value = response.data?.listWishlist;
      filteredWishlist.value = wishlist.value;
    } else {
      showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan");
    }
    super.onInit();
  }

  void sort() {
    filteredWishlist.value?.sort((a, b) {
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
      filteredWishlist.value = wishlist.value?.where((wishlist) {
        final String judul = (wishlist.buku?.judul ?? "").toLowerCase();
        final String keyword = text.toLowerCase();
        bool searchedItem = judul.contains(keyword);
        return isOnSearch ? searchedItem : true;
      }).toList();
    });
  }
}
