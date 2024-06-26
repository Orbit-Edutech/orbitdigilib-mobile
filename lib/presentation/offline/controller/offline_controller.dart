import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../sql/books/data/get_buku_sqlite.dart';
import '../../../sql/books/model/model_buku_sql.dart';
import '../../../utils/shared_preferences_manager.dart';

class OfflinePageController extends GetxController {
  Rx<List<ModelBukuSql>?> localBooks = Rx<List<ModelBukuSql>?>(null);

  final textController = TextEditingController();
  final searchFocusNode = FocusNode();

  final scrollController = ScrollController();
  Rx<int> page = 1.obs;
  Rx<bool> isOnSearch = false.obs;
  Rx<String> filter = "Semua Koleksi".obs;
  Timer? _timer;

  @override
  Future<void> onInit() async {
    final idUser = await SharedPreferencesManager.readPref("idUser");
    localBooks.value = (await getBukuSQLite(idUser ?? "")).where((buku) => buku.assetBukuPath != null).toList();

    final connectivity = Connectivity();
    final connectivities = await connectivity.checkConnectivity();
    connectivities.map((connectivity) {
      // TODO: Implement network info
    });

    super.onInit();
  }

  void search(String keyword) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(Duration(milliseconds: keyword.isEmpty ? 0 : 250), () async {
      final idUser = await SharedPreferencesManager.readPref("idUser");
      localBooks.value = null;
      localBooks.value = (await getBukuSQLite(idUser ?? ""))
          .where((buku) => buku.assetBukuPath != null && buku.judul.contains(keyword))
          .toList();

      update();
    });
  }

  void onSearch() {
    isOnSearch.value = !isOnSearch.value;
  }
}
