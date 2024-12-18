import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../sql/books/data/get_one_buku_sqlite.dart';
import '../../../sql/books/data/update_buku_sqlite.dart';
import '../../../sql/books/model/model_buku_sql.dart';
import '../../../sql/stared-pages/data/delete_stared_page.dart';
import '../../../sql/stared-pages/data/get_stared_pages.dart';
import '../../../sql/stared-pages/data/insert_stared_page.dart';
import '../../../utils/shared_preferences_manager.dart';
import '../../offline/controller/offline_controller.dart';
import '../../read/widgets/read_go_to_page.dart';

class OfflineReadController extends GetxController {
  final offlinePageController = Get.find<OfflinePageController>();
  Rx<ModelBukuSql?> buku = Rx<ModelBukuSql?>(null);
  Rx<File?> pdf = Rx<File?>(null);
  Rx<List<int>?> staredPages = Rx<List<int>?>(null);

  PdfViewerController pdfController = PdfViewerController();
  PdfTextSearchResult searchResult = PdfTextSearchResult();

  final searchController = TextEditingController();
  final searchPageController = TextEditingController();
  final searchFocusNode = FocusNode();
  final searchPageFocusNode = FocusNode();

  Timer? _timer;
  Rx<int> currentPage = 1.obs;
  int? lastPageSeen;
  Rx<bool> isFullScreen = false.obs;
  Rx<bool> isOnSearch = false.obs;
  Rx<bool> noResultFound = false.obs;
  bool isSample = false;
  int sampleLimit = 10;
  Rx<bool> isAssetBukuNull = false.obs;

  @override
  void onInit() async {
    await getBuku();
    pdf.value = File(buku.value?.assetBukuPath ?? "");
    staredPages.value = await getStaredPages();

    super.onInit();
  }

  Future getBuku() async {
    final idUser = await SharedPreferencesManager.readPref("idUser");
    final String idBuku = Get.arguments;
    buku.value = await getOneBukuSQLite(idBuku, idUser);
    final dir = await getApplicationCacheDirectory();
    final assetBukuPath = "${dir.path}/${buku.value?.idBuku}.pdf";
    await updateBukuSQLite(
      bukuId: buku.value?.idBuku ?? "",
      userId: idUser ?? "",
      values: {
        "last_page_seen": lastPageSeen ?? 1,
        "status": currentPage.value == buku.value?.totalPages ? "Selesai Dibaca" : "Belum Selesai",
        "asset_buku_path": assetBukuPath
      },
    );
    lastPageSeen = await getLastPageSeen(buku.value?.idBuku ?? "");
    await offlinePageController.onInit();
  }

  Future<int> getLastPageSeen(String idBuku) async {
    final idUser = await SharedPreferencesManager.readPref("idUser");
    final result = await getOneBukuSQLite(idBuku, idUser ?? "");
    return result?.lastPageSeen ?? 1;
  }

  void onPageChanged(int page) {
    currentPage.value = page;
    if (isSample && page > sampleLimit) {
      pdfController.jumpToPage(sampleLimit);
      return;
    }
    if (page > (lastPageSeen ?? 1)) {
      lastPageSeen = page;
      if (_timer?.isActive ?? false) _timer?.cancel();
      _timer = Timer(const Duration(seconds: 2), () async {
        final buku = this.buku.value;
        final dir = await getApplicationCacheDirectory();
        final assetBukuPath = "${dir.path}/${buku?.idBuku}.pdf";
        final idUser = await SharedPreferencesManager.readPref("idUser");
        await updateBukuSQLite(
          bukuId: buku?.idBuku ?? "",
          userId: idUser,
          values: {
            "last_page_seen": lastPageSeen ?? 1,
            "status": currentPage.value == buku?.totalPages ? "Selesai Dibaca" : "Belum Selesai",
            "asset_buku_path": assetBukuPath
          },
        );
        await offlinePageController.onInit();
      });
    }
  }

  void goToLastPageSeen() {
    pdfController.jumpToPage(lastPageSeen ?? 1);
  }

  void showPageSearchDiaog() {
    Get.dialog(
      ReadGoToPage(
        searchPageController: searchPageController,
        searchPageFocusNode: searchPageFocusNode,
        pdfController: pdfController,
        isSample: isSample,
        sampleLimit: sampleLimit,
        onPageChanged: onPageChanged,
      ),
      transitionDuration: const Duration(milliseconds: 100),
    );
  }

  Future<List<int>> getStaredPages() async {
    final idUser = await SharedPreferencesManager.readPref("idUser");
    final pages = await getStaredPagesSQLite(buku.value?.idBuku ?? "", idUser);
    final result = pages.map((e) => e.halaman ?? 0).toList();
    result.sort();
    return result;
  }

  void onStarChanged() async {
    final idUser = await SharedPreferencesManager.readPref("idUser");
    if (staredPages.value?.contains(currentPage.value) ?? false) {
      await deleteStaredPageSQLite(
        idBuku: buku.value?.idBuku ?? "",
        idUser: idUser ?? "",
        halaman: currentPage.value,
      );
    } else {
      await insertStaredPageSQLite(
        idBuku: buku.value?.idBuku ?? "",
        idUser: idUser ?? "",
        halaman: currentPage.value,
      );
    }
    staredPages.value = await getStaredPages();
  }
}
