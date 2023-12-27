import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../constants/sizes.dart';
import '../widgets/token_info.dart';

class TokenController extends GetxController {
  final voucherController = TextEditingController();
  final voucherFocusNode = FocusNode();

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
}
