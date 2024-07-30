import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/instance_manager.dart';
import 'package:path_provider/path_provider.dart';

import '../../../api/api_client.dart';
import '../../../api/api_path.dart';
import '../../../api/koleksi/data/get_koleksi.dart';
import '../../../api/koleksi/model/model_koleksi.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../sql/books/data/get_buku_sqlite.dart';
import '../../../sql/books/data/insert_buku_sqlite.dart';
import '../../../sql/books/data/update_buku_sqlite.dart';
import '../../../sql/books/model/model_buku_sql.dart';
import '../../../theme/app_color.dart';
import '../../profile/controller/profile_controller.dart';

class CollectionController extends GetxController {
  final user = Get.find<ProfileController>().profile.value;

  Rx<List<Payload>?> collections = Rx<List<Payload>?>(null);
  Rx<List<ModelBukuSql>?> localBooks = Rx<List<ModelBukuSql>?>(null);
  CancelToken cancelToken = CancelToken();

  final profileController = Get.find<ProfileController>();
  final textController = TextEditingController();
  final searchFocusNode = FocusNode();

  Rx<int> page = 1.obs;
  Rx<String> filter = "Semua Koleksi".obs;
  final scrollController = ScrollController();
  Rx<bool> isLoadedMore = false.obs;
  Rx<bool> isOnSearch = false.obs;
  Timer? _timer;

  @override
  Future<void> onInit() async {
    await loadCollections(filter.value != "Semua Koleksi" ? filter.value : null);
    scrollController.addListener(loadMore);
    super.onInit();
  }

  void search(String keyword) {
    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(Duration(milliseconds: keyword.isEmpty ? 0 : 250), () async {
      collections.value = null;
      Map<String, dynamic> qp = {};
      if (keyword.trim().isNotEmpty) {
        qp["buku[judul][lke]"] = keyword;
      }
      if (filter.value != "Semua Koleksi") {
        qp["tipe"] = filter.value;
      }
      cancelToken.cancel();
      cancelToken = CancelToken();
      final response = await getCollections(qp, cancelToken);
      if (response.data != null) {
        collections.value = response.data?.payload;
        await synchronizeData(collections.value!);
        page.value = 2;
      }
      update();
    });
  }

  void onSearch() {
    isOnSearch.value = !isOnSearch.value;
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
    for (Payload payload in response) {
      final isExist = localBooks.value?.firstWhereOrNull((lb) => lb.idBuku == (payload.bukuAnggota?.id ?? '-')) != null;
      final buku = payload.bukuAnggota;
      if (!isExist) {
        final dir = await getApplicationCacheDirectory();
        final savePath = "${dir.path}/${payload.bukuAnggota?.id}.png";
        await apiClient.download(
          param: APIParam(
            path: APIPath.publicAsset(payload.bukuAnggota?.assetSampulId ?? ''),
            fromJson: (e) => e,
          ),
          savePath: savePath,
        );
        final assetSampulPath = File(savePath).path;
        await insertBukuSQLite(
          ModelBukuSql(
            idBuku: buku?.id ?? "",
            idUser: idUser,
            lastPageSeen: 1,
            totalPages: buku?.jumlahHalaman ?? 1,
            status: "Belum Dibaca",
            expired: payload.waktuHabis ?? DateTime.now().add(const Duration(days: 7)),
            assetSampulPath: assetSampulPath,
            assetBukuPath: null,
            judul: buku?.judul ?? "-",
            penulis: buku?.penulis ?? "-",
            tipe: payload.tipe ?? "",
          ),
        );
      } else {
        await updateBukuSQLite(
          bukuId: buku?.id ?? "",
          userId: idUser,
          values: {
            "expired":
                payload.waktuHabis?.toIso8601String() ?? DateTime.now().add(const Duration(days: 7)).toIso8601String(),
            "tipe": payload.tipe ?? "",
          },
        );
      }
    }

    localBooks.value = await getBukuSQLite(user?.id ?? "");
  }
}
