import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../api/buku/data/buku_get_all.dart';
import '../../../api/buku/model/model_all_buku.dart';
import '../../../api/perpustakaan/data/perpustakaan_get_one.dart';
import '../../../api/perpustakaan/model/model_perpustakaan.dart';
import '../../../utils/shared_preferences_manager.dart';

class IndexController extends GetxController {
  final Rx<Perpustakaan?> perpustakaan = Rx<Perpustakaan?>(null);
  // kategori-buku-perpustakaan
  List<String>? categories;
  List<Payload>? pinnedBooks;
  List<Payload>? allBooks;

  @override
  void onInit() async {
    final kode = await SharedPreferencesManager.readPref("kodePerpustakaan");
    final id = await SharedPreferencesManager.readPref("idPerpustakaan");
    debugPrint(id.toString());
    Future.wait([
      getOnePerpustakaan(kode).then((res) {
        if (res.data != null) {
          perpustakaan.value = res.data;
        } else {
          // TODO: Show error snackbar
        }
      }),
      getAllBuku({"isPin": true}).then((res) {
        if (res.data != null) {
          pinnedBooks = res.data!.payload;
        } else {
          // TODO: Show error snackbar
        }
      }),
      getAllBuku().then((res) {
        if (res.data != null) {
          allBooks = res.data!.payload;
        } else {
          // TODO: Show error snackbar
        }
      })
    ]);
    super.onInit();
  }
}
