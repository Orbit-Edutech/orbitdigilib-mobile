import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_client.dart';
import '../../../api/transaksi/data/pinjam_my_history.dart';
import '../../../api/transaksi/data/sewa_my_history.dart';
import '../../../api/transaksi/model/model_pinjam.dart';
import '../../../api/transaksi/model/model_sewa.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';

class TransaksiDigitalController extends GetxController {
  // Pinjam
  Rx<List<ModelPinjam>?> pinjamList = Rx<List<ModelPinjam>?>(null);
  final pinjamSearchCtrl = TextEditingController();
  final RxString pinjamSearchQuery = ''.obs;
  final Rx<DateTime?> pinjamDateFrom = Rx<DateTime?>(null);
  final Rx<DateTime?> pinjamDateTo = Rx<DateTime?>(null);

  // Sewa
  Rx<List<ModelSewa>?> sewaList = Rx<List<ModelSewa>?>(null);
  final sewaSearchCtrl = TextEditingController();
  final RxString sewaSearchQuery = ''.obs;
  final Rx<DateTime?> sewaDateFrom = Rx<DateTime?>(null);
  final Rx<DateTime?> sewaDateTo = Rx<DateTime?>(null);

  List<ModelPinjam>? get filteredPinjam {
    final list = pinjamList.value;
    if (list == null) return null;
    final q = pinjamSearchQuery.value.toLowerCase();
    final from = pinjamDateFrom.value;
    final to = pinjamDateTo.value;
    return list.where((item) {
      if (q.isNotEmpty) {
        final judul = item.bukuPerpust?.buku?.judul?.toLowerCase() ?? '';
        final penulis = item.bukuPerpust?.buku?.penulis?.toLowerCase() ?? '';
        if (!judul.contains(q) && !penulis.contains(q)) return false;
      }
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

  List<ModelSewa>? get filteredSewa {
    final list = sewaList.value;
    if (list == null) return null;
    final q = sewaSearchQuery.value.toLowerCase();
    final from = sewaDateFrom.value;
    final to = sewaDateTo.value;
    return list.where((item) {
      if (q.isNotEmpty) {
        final judul = item.bukuAnggota?.judul?.toLowerCase() ?? '';
        final penulis = item.bukuAnggota?.penulis?.toLowerCase() ?? '';
        if (!judul.contains(q) && !penulis.contains(q)) return false;
      }
      if (from != null && item.tanggalSewa != null) {
        if (item.tanggalSewa!.isBefore(from)) return false;
      }
      if (to != null && item.tanggalSewa != null) {
        final toEnd = DateTime(to.year, to.month, to.day, 23, 59, 59);
        if (item.tanggalSewa!.isAfter(toEnd)) return false;
      }
      return true;
    }).toList();
  }

  void clearPinjamFilters() {
    pinjamSearchCtrl.clear();
    pinjamSearchQuery.value = '';
    pinjamDateFrom.value = null;
    pinjamDateTo.value = null;
  }

  void clearSewaFilters() {
    sewaSearchCtrl.clear();
    sewaSearchQuery.value = '';
    sewaDateFrom.value = null;
    sewaDateTo.value = null;
  }

  @override
  Future<void> onInit() async {
    await Future.wait([_loadPinjam(), _loadSewa()]);
    super.onInit();
  }

  @override
  void onClose() {
    pinjamSearchCtrl.dispose();
    sewaSearchCtrl.dispose();
    super.onClose();
  }

  Future<void> refreshPinjam() => _loadPinjam();
  Future<void> refreshSewa() => _loadSewa();

  Future<void> _loadPinjam() async {
    pinjamList.value = null;
    final res = await getPinjamMyHistory();
    if (res.data != null) {
      pinjamList.value = res.data!.payload ?? [];
    } else {
      _showError(res);
    }
  }

  Future<void> _loadSewa() async {
    sewaList.value = null;
    final res = await getSewaMyHistory();
    if (res.data != null) {
      sewaList.value = res.data!.payload ?? [];
    } else {
      _showError(res);
    }
  }

  void _showError(APIResponse res) {
    if (res.error == ResponseStatus.connectionError) {
      showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
    } else {
      showSnackbar(backgroundColor: AppColor.red, title: "Error ${res.statusCode}", message: res.error["message"]);
    }
  }
}
