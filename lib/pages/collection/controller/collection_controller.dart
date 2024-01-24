import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';

import '../../../api/api_client.dart';
import '../../../api/koleksi/data/get_koleksi.dart';
import '../../../api/koleksi/model/model_koleksi.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../sql/books/data/delete_buku_sqlite.dart';
import '../../../sql/books/data/get_buku_sqlite.dart';
import '../../../sql/books/data/insert_buku_sqlite.dart';
import '../../../sql/books/model/model_buku_sql.dart';
import '../../../theme/app_color.dart';
import '../../profile/controller/profile_controller.dart';

class CollectionController extends GetxController {
  Rx<List<Payload>?> allCollections = Rx<List<Payload>?>(null);
  Rx<List<ModelBukuSql>?> localBooks = Rx<List<ModelBukuSql>?>(null);

  final profileController = Get.find<ProfileController>();

  Rx<int> page = 1.obs;
  Rx<String> filter = "Semua Koleksi".obs;
  final scrollController = ScrollController();
  Rx<bool> isLoadedMore = false.obs;

  @override
  Future<void> onInit() async {
    allCollections.value = null;
    final response = await getCollections();
    if (response.data != null) {
      allCollections.value = response.data?.payload;
      await synchronizeData(allCollections.value!);
      page.value = 2;
    } else {
      if (response.error == ResponseStatus.connectionError) {
        showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
      } else {
        showSnackbar(
          backgroundColor: AppColor.red,
          title: "Error ${response.statusCode}",
          message: response.error["message"],
        );
      }
    }
    scrollController.addListener(loadMore);
    super.onInit();
  }

  Future<void> loadMore() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoadedMore.value) {
      isLoadedMore.value = true;
      final response = await getCollections({"page": page.value});
      if (response.data != null) {
        if (response.data!.payload?.isNotEmpty ?? false) {
          allCollections.value?.addAll(response.data?.payload ?? []);
          final result = allCollections.value;
          allCollections.value = result;
          page.value++;
        }
      }
      isLoadedMore.value = false;
    }
  }

  void onFilterChange(String filter) => this.filter.value = filter;

  Future<void> synchronizeData(List<Payload> response) async {
    localBooks.value = await getBukuSQLite();
    final idUser = profileController.profile.value?.id ?? "";
    for (Payload book in response) {
      final isExist = localBooks.value?.firstWhereOrNull((lb) => lb.idBuku == (book.buku?.id ?? '-')) != null;
      if (!isExist) {
        await insertBukuSQLite(
          ModelBukuSql(
            idBuku: book.buku?.id ?? "",
            idUser: idUser,
            lastPageSeen: 0,
            totalPages: book.buku?.jumlahHalaman ?? 0,
            status: "Belum Dibaca",
            expired: book.waktuHabis ?? DateTime.now(),
          ),
        );
      }
    }
    for (ModelBukuSql lb in localBooks.value ?? []) {
      if (lb.expired.isBefore(DateTime.now())) {
        deleteBukuSQLite(idBuku: lb.idBuku, idUser: idUser);
      }
    }
  }
}
