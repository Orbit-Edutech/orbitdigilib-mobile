import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../api/api_client.dart';
import '../../../api/perpustakaan/data/perpustakaan_get_one.dart';
import '../../../api/perpustakaan/model/model_perpustakaan.dart';
import '../../../constants/sizes.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/shared_preferences_manager.dart';
import '../widgets/auth_register_info.dart';

class AuthLibraryController extends GetxController {
  final TextEditingController kodeController = TextEditingController();
  final FocusNode kodeFocusNode = FocusNode();

  final Rx<ButtonState> buttonState = ButtonState.disable.obs;
  final Rx<bool> isError = false.obs;
  final Rx<String?> errorMessage = Rx<String?>(null);
  Perpustakaan? perpustakaan;

  @override
  void onInit() async {
    final kode = await SharedPreferencesManager.readPref("kodePerpustakaan");
    if (kode != null) {
      kodeController.text = kode;
      buttonState.value = ButtonState.enable;
    }
    super.onInit();
  }

  Future<void> onSubmit() async {
    buttonState.value = ButtonState.loading;
    final kode = kodeController.text;
    final response = await getOnePerpustakaan(kode: kode);
    if (response.data != null) {
      perpustakaan = response.data;
      buttonState.value = ButtonState.enable;
      AppTheme.changePerpusTheme(perpustakaan!.warnaDasar);
      Get.toNamed(AppRoutes.authUser, arguments: perpustakaan);
    } else {
      if (response.error == ResponseStatus.connectionError) {
        errorMessage.value = "Kesalahan koneksi";
      } else {
        errorMessage.value = response.error["message"].toString();
      }
      isError.value = true;
      buttonState.value = ButtonState.disable;
    }
  }

  void onKodeChanged(String text) {
    if (isError.value) {
      isError.value = false;
      buttonState.value = ButtonState.enable;
    }
    buttonState.value = text.isEmpty ? ButtonState.disable : ButtonState.enable;
  }

  void showRegisterInfo() {
    Get.bottomSheet(
      SizedBox(
        height: Get.size.height * 0.75,
        width: Get.size.width,
        child: const RegisterInfo(),
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
