import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class WishlistController extends GetxController {
  Timer? _timer;
  Rx<bool> asc = false.obs;

  final textController = TextEditingController();
  final focusNode = FocusNode();

  final books = <String>[];
  Rx<List<String>?> filteredBooks = Rx<List<String>?>(null);

  @override
  void onInit() {
    // TODO: Sambungin ke API
    filteredBooks.value = books;
    super.onInit();
  }

  void sort() {
    filteredBooks.value?.sort((a, b) {
      return asc.value ? b.compareTo(a) : a.compareTo(b);
    });
    asc.value = !asc.value;
  }

  void onSearch(String text) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 250), () {
      bool isOnSearch = text != "";
      filteredBooks.value = books.where((book) {
        final String keyword = text.toLowerCase();
        bool searchedItem = book.toLowerCase().contains(keyword);
        return isOnSearch ? searchedItem : true;
      }).toList();
    });
  }
}
