import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_client.dart';
import '../../../api/transaksi-fisik/data/transaksi_fisik_my_history.dart';
import '../../../api/transaksi-fisik/model/model_transaksi_fisik.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';

class TransaksiFisikController extends GetxController {
  Rx<List<TransaksiFisikItem>?> transaksi = Rx<List<TransaksiFisikItem>?>(null);

  final searchCtrl = TextEditingController();
  final RxString searchQuery = ''.obs;
  final RxString filterStatus = ''.obs; // '' = semua
  final Rx<DateTime?> dateFrom = Rx<DateTime?>(null);
  final Rx<DateTime?> dateTo = Rx<DateTime?>(null);

  List<TransaksiFisikItem>? get filtered {
    final list = transaksi.value;
    if (list == null) return null;

    final q = searchQuery.value.toLowerCase();
    final status = filterStatus.value;
    final from = dateFrom.value;
    final to = dateTo.value;

    return list.where((item) {
      if (q.isNotEmpty) {
        final judul = item.bukuFisik?.judul?.toLowerCase() ?? '';
        final penulis = item.bukuFisik?.penulis?.toLowerCase() ?? '';
        if (!judul.contains(q) && !penulis.contains(q)) return false;
      }
      if (status.isNotEmpty && item.status != status) return false;
      if (from != null && item.tanggalPinjam != null) {
        if (item.tanggalPinjam!.isBefore(from)) return false;
      }
      if (to != null && item.tanggalPinjam != null) {
        final toEnd = DateTime(to.year, to.month, to.day, 23, 59, 59);
        if (item.tanggalPinjam!.isAfter(toEnd)) return false;
      }
      return true;
    }).toList();
  }

  bool get hasActiveFilter =>
      searchQuery.value.isNotEmpty ||
      filterStatus.value.isNotEmpty ||
      dateFrom.value != null ||
      dateTo.value != null;

  void clearFilters() {
    searchCtrl.clear();
    searchQuery.value = '';
    filterStatus.value = '';
    dateFrom.value = null;
    dateTo.value = null;
  }

  @override
  Future<void> onInit() async {
    await _load();
    super.onInit();
  }

  @override
  void onClose() {
    searchCtrl.dispose();
    super.onClose();
  }

  Future<void> _load() async {
    transaksi.value = null;
    final res = await getTransaksiFisikMyHistory();
    if (res.data != null) {
      transaksi.value = res.data!.payload ?? [];
    } else {
      if (res.error == ResponseStatus.connectionError) {
        showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
      } else {
        showSnackbar(backgroundColor: AppColor.red, title: "Error ${res.statusCode}", message: res.error["message"]);
      }
    }
  }
}
