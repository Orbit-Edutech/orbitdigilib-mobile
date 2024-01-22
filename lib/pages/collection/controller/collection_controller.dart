import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';

import '../../../api/api_client.dart';
import '../../../api/koleksi/data/get_koleksi.dart';
import '../../../api/koleksi/model/model_koleksi.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../sql/books/data/get_buku_local.dart';
import '../../../sql/books/data/insert_buku.dart';
import '../../../sql/books/model/model_buku_sql.dart';
import '../../../sql/sql_helper.dart';
import '../../../theme/app_color.dart';
import '../../profile/controller/profile_controller.dart';

class CollectionController extends GetxController {
  final profileController = Get.find<ProfileController>();

  Rx<int> page = 0.obs;
  Rx<String> filter = "Semua Koleksi".obs;
  final scrollController = ScrollController();
  ModelKoleksi? collections;
  Rx<List<Payload>?> allCollections = Rx<List<Payload>?>(null);
  Rx<bool> isLoadedMore = false.obs;

  @override
  Future<void> onInit() async {
    allCollections.value = null;
    final response = await getCollections();
    if (response.data != null) {
      allCollections.value = response.data?.payload;
      synchronizeData(allCollections.value!);
      page.value = 1;
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

  void synchronizeData(List<Payload> response) async {
    final localBooks = await getBukuLocal(SQLParam(table: sqlHelper.constants.table.buku));
    log(localBooks.toString());
    for (var book in response) {
      final isExist = localBooks.firstWhereOrNull((lb) => lb['id_buku'] == (book.buku?.id ?? '-')) != null;
      if (!isExist) {
        await insertBukuLocal(
          ModelBukuSql(
            idBuku: book.buku?.id ?? "",
            idUser: profileController.profile.value?.id ?? "",
            lastPageSeen: 0,
            totalPages: book.buku?.jumlahHalaman ?? 0,
            status: "unread",
          ),
        );
      } else {}
    }
  }
}
