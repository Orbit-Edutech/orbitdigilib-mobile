import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../api/api_client.dart';
import '../../../api/koleksi/data/get_koleksi.dart';
import '../../../api/koleksi/model/model_koleksi.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';

class CollectionController extends GetxController {
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
}
