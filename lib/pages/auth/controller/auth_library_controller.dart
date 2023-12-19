import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../api/auth/data/get_one_perpustakaan.dart';
import '../../../api/auth/model/model_auth_perpustakaan.dart';
import '../../../constants/sizes.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/pages/register_info.dart';
import '../../../shared/widget/app_button.dart';
import '../../../theme/app_color.dart';
import '../../../utils/get_perpus_color.dart';

class AuthLibraryController extends GetxController {
  final TextEditingController kodeController = TextEditingController();
  final FocusNode kodeFocusNode = FocusNode();

  final Rx<ButtonState> buttonState = ButtonState.disable.obs;
  final Rx<bool> isError = false.obs;
  final Rx<String?> errorMessage = Rx<String?>(null);
  AuthPerpustakaan? perpustakaan;

  Future<void> onSubmit() async {
    buttonState.value = ButtonState.loading;
    final kode = kodeController.text;
    final response = await getOnePerpustakaan(kode);
    if (response.data != null) {
      perpustakaan = response.data;
      buttonState.value = ButtonState.enable;
      debugPrint(response.data?.toRawJson());
      changeTheme(perpustakaan);
      Get.toNamed(AppRoutes.authUser, arguments: perpustakaan);
    } else {
      debugPrint(response.error['message'].toString());
      isError.value = true;
      errorMessage.value = response.error["message"].toString();
      buttonState.value = ButtonState.disable;
    }
  }

  void changeTheme(AuthPerpustakaan? perpus) {
    final perpusColor = getPerpusColor(perpus?.warnaDasar ?? "Light Blue");
    const textTheme = TextTheme();
    final theme = ThemeData(
      scaffoldBackgroundColor: AppColor.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: perpusColor.seed,
        primary: perpusColor.primary,
      ),
      textTheme: GoogleFonts.robotoTextTheme(textTheme),
      useMaterial3: true,
    );
    Get.changeTheme(theme);
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
      isDismissible: false,
      enableDrag: false,
    );
  }
}
