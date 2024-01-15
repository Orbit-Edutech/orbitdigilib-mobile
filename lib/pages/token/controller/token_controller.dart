import 'package:flutter/widgets.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../api/api_client.dart';
import '../../../api/voucher/data/redeem_voucher.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';
import '../../profile/controller/profile_controller.dart';
import '../widgets/token_info.dart';

class TokenController extends GetxController {
  final voucherController = TextEditingController();
  final voucherFocusNode = FocusNode();

  final profileController = Get.find<ProfileController>();

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
    final voucher = voucherController.text;
    final response = await redeemVoucher(voucher);
    if (response.data != null) {
      voucherController.clear();
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
    }
  }
}
