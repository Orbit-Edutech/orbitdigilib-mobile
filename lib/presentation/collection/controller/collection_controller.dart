import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';

import '../../../api/api_client.dart';
import '../../../api/koleksi/data/get_koleksi.dart';
import '../../../api/koleksi/model/model_koleksi.dart';
import '../../../shared/widget/show_snackbar.dart';
// import '../../../sql/books/data/delete_buku_sqlite.dart';
import '../../../sql/books/data/get_buku_sqlite.dart';
import '../../../sql/books/data/insert_buku_sqlite.dart';
import '../../../sql/books/model/model_buku_sql.dart';
import '../../../theme/app_color.dart';
import '../../profile/controller/profile_controller.dart';

class CollectionController extends GetxController {
  final user = Get.find<ProfileController>().profile.value;

  Rx<List<Payload>?> collections = Rx<List<Payload>?>(null);
  Rx<List<ModelBukuSql>?> localBooks = Rx<List<ModelBukuSql>?>(null);

  final profileController = Get.find<ProfileController>();

  Rx<int> page = 1.obs;
  Rx<String> filter = "Semua Koleksi".obs;
  final scrollController = ScrollController();
  Rx<bool> isLoadedMore = false.obs;

  @override
  Future<void> onInit() async {
    await loadCollections(filter.value != "Semua Koleksi" ? filter.value : null);
    scrollController.addListener(loadMore);
    super.onInit();
  }

  Future<void> loadCollections([String? filter]) async {
    collections.value = null;
    final qp = filter != null ? {"tipe": filter} : null;
    final response = await getCollections(qp);
    if (response.data != null) {
      collections.value = response.data?.payload;
      await synchronizeData(collections.value!);
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
  }

  Future<void> loadMore() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isLoadedMore.value) {
      isLoadedMore.value = true;
      final Map<String, dynamic> qp = {"page": page.value};
      filter.value != "Semua Koleksi" ? qp['tipe'] = filter.value : null;
      final response = await getCollections(qp);
      if (response.data != null) {
        if (response.data!.payload?.isNotEmpty ?? false) {
          collections.value?.addAll(response.data?.payload ?? []);
          final result = collections.value;
          collections.value = result;
          await synchronizeData(collections.value!);
          page.value++;
        }
      }
      isLoadedMore.value = false;
    }
  }

  void onChangeFilter(String filter) {
    this.filter.value = filter;
    loadCollections(filter != "Semua Koleksi" ? this.filter.value : null);
  }

  Future<void> synchronizeData(List<Payload> response) async {
    localBooks.value = await getBukuSQLite(user?.id ?? "");
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
            expired: book.waktuHabis ?? DateTime.now().add(const Duration(days: 7)),
          ),
        );
      }
    }
    // for (ModelBukuSql lb in localBooks.value ?? []) {
    //   if (lb.expired.isBefore(DateTime.now())) {
    //     deleteBukuSQLite(idBuku: lb.idBuku, idUser: idUser);
    //   }
    // }
    localBooks.value = await getBukuSQLite(user?.id ?? "");
  }
}
