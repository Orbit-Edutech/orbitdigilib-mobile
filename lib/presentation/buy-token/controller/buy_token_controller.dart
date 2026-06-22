import 'package:get/get.dart';

import '../../../api/api_client.dart';
import '../../../api/paket-token/data/get_paket_token.dart';
import '../../../api/paket-token/model/model_paket_token.dart';
import '../../../api/topup/data/get_topup_status.dart';
import '../../../api/topup/data/post_topup.dart';
import '../../../api/topup/model/model_topup.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';
import '../../profile/controller/profile_controller.dart';

class BuyTokenController extends GetxController {
  final profileController = Get.find<ProfileController>();

  Rx<List<PaketToken>?> paketList = Rx<List<PaketToken>?>(null);
  RxBool loadingPaket = true.obs;
  Rx<ButtonState> submitState = ButtonState.enable.obs;
  Rx<Topup?> createdTopup = Rx<Topup?>(null);
  RxString pollStatus = "PENDING".obs;
  bool _polling = false;

  /// Topup nominal bebas: 1 rupiah = tokenPerRupiah token.
  static const int tokenPerRupiah = 10;
  final RxInt customAmount = 0.obs;
  int get customTokens => customAmount.value * tokenPerRupiah;

  @override
  void onInit() {
    loadPaket();
    super.onInit();
  }

  Future<void> loadPaket() async {
    loadingPaket.value = true;
    final res = await getPaketToken();
    if (res.data != null) {
      paketList.value = res.data!.listPaketToken;
    } else {
      _showError(res);
    }
    loadingPaket.value = false;
  }

  Future<void> submitTopup(PaketToken paket, String metode, String? bankCode) async {
    await _submit(paketTokenId: paket.id ?? "", metode: metode, bankCode: bankCode);
  }

  /// Topup dengan nominal bebas (token dihitung backend = nominal × 10).
  Future<void> submitCustomTopup(int amount, String metode, String? bankCode) async {
    await _submit(customAmount: amount, metode: metode, bankCode: bankCode);
  }

  Future<void> _submit({
    String? paketTokenId,
    int? customAmount,
    required String metode,
    String? bankCode,
  }) async {
    submitState.value = ButtonState.loading;
    final res = await postTopup(
      paketTokenId: paketTokenId,
      customAmount: customAmount,
      metode: metode,
      bankCode: bankCode,
    );
    submitState.value = ButtonState.enable;
    if (res.data != null && res.data!.id != null) {
      createdTopup.value = res.data;
      pollStatus.value = res.data!.status ?? "PENDING";
      Get.toNamed(AppRoutes.topupDetail);
      startPolling(res.data!.id!);
    } else {
      _showError(res);
    }
  }

  Future<void> startPolling(String id) async {
    _polling = true;
    while (_polling && !isClosed) {
      await Future.delayed(const Duration(seconds: 5));
      if (!_polling || isClosed) break;
      await checkStatus(id, silent: true);
    }
  }

  void stopPolling() {
    _polling = false;
  }

  Future<void> checkStatus(String id, {bool silent = false}) async {
    final res = await getTopupStatus(id);
    if (res.data != null && res.data!.status != null) {
      pollStatus.value = res.data!.status!;
      if (res.data!.status == "PAID") {
        stopPolling();
        showSnackbar(
          backgroundColor: AppColor.green,
          message: "Pembayaran berhasil! Token telah ditambahkan.",
        );
        await Get.find<ProfileController>().onInit();
        Get.until((route) => route.settings.name == AppRoutes.token || route.isFirst);
      } else if ((res.data!.status == "EXPIRED" || res.data!.status == "FAILED") && !silent) {
        showSnackbar(backgroundColor: AppColor.red, message: "Pembayaran ${res.data!.status}");
      }
    } else if (!silent) {
      _showError(res);
    }
  }

  void _showError(APIResponse res) {
    if (res.error == ResponseStatus.connectionError) {
      showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
    } else {
      showSnackbar(
        backgroundColor: AppColor.red,
        title: "Error ${res.statusCode}",
        message: res.error is Map ? res.error["message"] : "Terjadi kesalahan",
      );
    }
  }

  @override
  void onClose() {
    stopPolling();
    super.onClose();
  }
}
