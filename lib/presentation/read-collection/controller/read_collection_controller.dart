import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../api/api_client.dart';
import '../../../api/api_path.dart';
import '../../../api/buku/data/buku_anggota_get_one.dart';
import '../../../api/koleksi/model/model_koleksi.dart';
import '../../../api/laporan-literasi/data/post_laporan_literasi.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../sql/books/data/get_one_buku_sqlite.dart';
import '../../../sql/books/data/insert_buku_sqlite.dart';
import '../../../sql/books/data/update_buku_sqlite.dart';
import '../../../sql/books/model/model_buku_sql.dart';
import '../../../sql/stared-pages/data/delete_stared_page.dart';
import '../../../sql/stared-pages/data/get_stared_pages.dart';
import '../../../sql/stared-pages/data/insert_stared_page.dart';
import '../../../theme/app_color.dart';
import '../../collection/controller/collection_controller.dart';
import '../../profile/controller/profile_controller.dart';
import '../widgets/read_collection_go_to_page.dart';
import '../widgets/read_collection_menu.dart';

class ReadCollectionController extends GetxController {
  final profileController = Get.find<ProfileController>();
  final collectionController = Get.find<CollectionController>();

  PdfViewerController pdfController = PdfViewerController();
  PdfTextSearchResult searchResult = PdfTextSearchResult();

  final searchController = TextEditingController();
  final searchPageController = TextEditingController();
  final searchFocusNode = FocusNode();
  final searchPageFocusNode = FocusNode();

  DateTime? startTime;
  Timer? readTimer;
  Duration readDuration = Duration.zero;
  Timer? _timer;
  Rx<int> currentPage = 1.obs;
  int? lastPageSeen;
  Rx<bool> isFullScreen = false.obs;
  Rx<bool> isOnSearch = false.obs;
  Rx<bool> isOnDownload = false.obs;
  Rx<bool> noResultFound = false.obs;
  bool isSample = false;
  int sampleLimit = 10;
  Rx<double> downloadProgress = 0.0.obs;
  Rx<bool> isAssetBukuNull = false.obs;

  Rx<BukuAnggota?> buku = Rx<BukuAnggota?>(null);
  Rx<File?> pdf = Rx<File?>(null);
  Rx<List<int>?> staredPages = Rx<List<int>?>(null);

  @override
  Future<void> onInit() async {
    await getBuku();
    pdf.value = await downloadPdf();
    staredPages.value = await getStaredPages();
    startTime = DateTime.now();
    readTimer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      readDuration = DateTime.now().difference(startTime!);
    });
    super.onInit();
  }

  Future getBuku() async {
    final idUser = profileController.profile.value?.id ?? "";
    final Map<String, String?> args = Get.arguments;
    isSample = args["type"] == "sample";
    final response = await getOneBukuAnggota(args["asset"] ?? "");
    if (response.data != null) {
      buku.value = response.data;
      final dir = await getApplicationCacheDirectory();
      final assetBukuPath = "${dir.path}/${buku.value?.id}.pdf";
      final localBook = await getOneBukuSQLite(buku.value?.id ?? "", idUser);
      if (!isSample) {
        if (localBook == null) {
          final savePath = "${dir.path}/${response.data?.id}";
          final assetSampulPath = File(savePath).path;
          await insertBukuSQLite(
            ModelBukuSql(
              idBuku: buku.value?.id ?? "",
              idUser: idUser,
              lastPageSeen: 1,
              totalPages: buku.value?.jumlahHalaman ?? 1,
              status: "Belum Dibaca",
              expired: DateTime.now().add(const Duration(days: 7)),
              assetSampulPath: assetSampulPath,
              assetBukuPath: assetBukuPath,
              judul: buku.value?.judul ?? "-",
              penulis: buku.value?.penulis ?? "-",
              tipe: "",
            ),
          );
        } else {
          await updateBukuSQLite(
            bukuId: buku.value?.id ?? "",
            userId: profileController.profile.value?.id ?? "",
            values: {
              "last_page_seen": lastPageSeen ?? 1,
              "status": currentPage.value == buku.value?.jumlahHalaman ? "Selesai Dibaca" : "Belum Selesai",
              "asset_buku_path": assetBukuPath,
            },
          );
        }
      }
      lastPageSeen = await getLastPageSeen(response.data?.id ?? "");
      await collectionController.onInit();
    } else {
      showSnackbar(message: "Terjadi kesalahan", backgroundColor: AppColor.red);
    }
  }

  Future<File?> downloadPdf() async {
    isOnDownload.value = true;
    final String? pdfId = buku.value?.assetBukuId;
    if (pdfId != null) {
      final dir = await getApplicationCacheDirectory();
      final pdfPath = "${dir.path}/${buku.value?.id}.pdf";
      if (!(await File(pdfPath).exists())) {
        await apiClient.download(
          param: APIParam(
            path: APIPath.asset(pdfId),
            fromJson: (data) => data,
            onReceiveProgress: (p0, p1) {
              downloadProgress.value = p0 / p1;
            },
          ),
          savePath: pdfPath,
        );
      }
      final imgPath = "${dir.path}/${buku.value?.id}";
      if (!(await File(imgPath).exists())) {
        await apiClient.download(
          param: APIParam(
            path: APIPath.asset(pdfId),
            fromJson: (data) => data,
            onReceiveProgress: (p0, p1) {
              downloadProgress.value = p0 / p1;
            },
          ),
          savePath: imgPath,
        );
      }

      final result = File(pdfPath);
      isOnDownload.value = false;
      return result;
    }
    isAssetBukuNull.value = true;
    isOnDownload.value = false;
    return null;
  }

  Future<int> getLastPageSeen(String idBuku) async {
    final result = await getOneBukuSQLite(idBuku, profileController.profile.value?.id ?? "");
    return result?.lastPageSeen ?? 1;
  }

  Future<List<int>> getStaredPages() async {
    final pages = await getStaredPagesSQLite(
      buku.value?.id ?? "",
      profileController.profile.value?.id ?? "",
    );
    final result = pages.map((e) => e.halaman ?? 0).toList();
    result.sort();
    return result;
  }

  void goToLastPageSeen() {
    pdfController.jumpToPage(lastPageSeen ?? 1);
  }

  void onPageChanged(int page) {
    if (currentPage.value != page) {
      if (readTimer?.isActive ?? false) readTimer?.cancel();
      readTimer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        readDuration = DateTime.now().difference(startTime!);
      });
      if (readDuration.inSeconds >= 1) {
        postLaporanLiterasi(
          bukuId: Get.arguments["bukuId"],
          halaman: currentPage.value,
          durasi: readDuration.inSeconds,
        );
      }
      startTime = DateTime.now();
      readDuration = Duration.zero;
    }
    currentPage.value = page;
    if (isSample && page > sampleLimit) {
      pdfController.jumpToPage(sampleLimit);
      return;
    }
    if (page > (lastPageSeen ?? 1)) {
      lastPageSeen = page;
      if (_timer?.isActive ?? false) _timer?.cancel();
      _timer = Timer(const Duration(seconds: 2), () async {
        final dir = await getApplicationCacheDirectory();
        final assetBukuPath = "${dir.path}/${buku.value?.id}.pdf";
        await updateBukuSQLite(
          bukuId: buku.value?.id ?? "",
          userId: profileController.profile.value?.id ?? "",
          values: {
            "last_page_seen": lastPageSeen ?? 1,
            "status": currentPage.value == buku.value?.jumlahHalaman ? "Selesai Dibaca" : "Belum Selesai",
            "asset_buku_path": assetBukuPath
          },
        );
        await collectionController.onInit();
      });
    }
  }

  void onStarChanged() async {
    if (staredPages.value?.contains(currentPage.value) ?? false) {
      await deleteStaredPageSQLite(
        idBuku: buku.value?.id ?? "",
        idUser: profileController.profile.value?.id ?? "",
        halaman: currentPage.value,
      );
    } else {
      await insertStaredPageSQLite(
        idBuku: buku.value?.id ?? "",
        idUser: profileController.profile.value?.id ?? "",
        halaman: currentPage.value,
      );
    }
    staredPages.value = await getStaredPages();
  }

  void showMenu() {
    Get.bottomSheet(
      const ReadCollectionMenu(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.r)),
      ),
      isScrollControlled: true,
      enableDrag: false,
    );
  }

  void showPageSearchDiaog() {
    Get.dialog(
      ReadCollectionGoToPage(
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
}
