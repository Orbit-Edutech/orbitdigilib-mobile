import 'package:flutter/widgets.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../api/api_client.dart';
import '../../../api/voucher-info/data/get_voucher_info_all.dart';
import '../../../api/voucher-info/model/model_voucher_info_all.dart';
import '../../../api/voucher/data/redeem_voucher.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';
import '../../profile/controller/profile_controller.dart';
import '../widgets/token_info.dart';

class TokenController extends GetxController {
  Rx<List<GetVoucher>?> listInfoVoucher = Rx<List<GetVoucher>?>(null);

  final voucherController = TextEditingController();
  final voucherFocusNode = FocusNode();
  Rx<ButtonState> buttonState = ButtonState.disable.obs;

  final profileController = Get.find<ProfileController>();

  @override
  void onInit() async {
    final response = await getVoucherInfoAll();
    if (response.data != null) {
      listInfoVoucher.value = response.data?.listGetVoucher ?? [];
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
    super.onInit();
  }

  void onChanged(String voucher) {
    buttonState.value = voucher.isEmpty ? ButtonState.disable : ButtonState.enable;
  }

  void showVoucherInfo() {
    Get.bottomSheet(
      SizedBox(
        height: Get.size.height * 0.75,
        width: Get.size.width,
        child: const TokenInfo(),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.r)),
      ),
      isScrollControlled: true,
      enableDrag: false,
    );
  }

  void redeem() async {
    buttonState.value = ButtonState.loading;
    final voucher = voucherController.text;
    final response = await redeemVoucher(voucher);
    if (response.data != null) {
      voucherController.clear();
      buttonState.value = ButtonState.disable;
      showSnackbar(backgroundColor: AppColor.green, message: "Voucher berhasil digunakan!");
      Get.find<ProfileController>().onInit();
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
      buttonState.value = ButtonState.enable;
    }
  }
}
