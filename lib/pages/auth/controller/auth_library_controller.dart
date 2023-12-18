import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../api/model/perpus_model.dart';
import '../../../constants/sizes.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../theme/app_color.dart';
import '../../../utils/get_perpus_color.dart';

class AuthLibraryController extends GetxController {
  final List<Perpus> listPerpus = [
    Perpus(name: "Perpustakaan Orbit", kode: "perpusorbit", color: "Purple", logo: ""),
    Perpus(name: "Perpustakaan Aku", kode: "perpusku", color: "Green", logo: ""),
    Perpus(name: "Library-an Indonesia", kode: "librarian", color: "Red", logo: ""),
  ];

  final TextEditingController kodeController = TextEditingController();
  final FocusNode kodeFocusNode = FocusNode();

  final Rx<ButtonState> buttonState = ButtonState.disable.obs;
  final Rx<bool> isError = false.obs;

  void onSubmit() {
    final perpus = listPerpus.firstWhereOrNull((perpus) => perpus.kode == kodeController.text);
    debugPrint(perpus?.toRawJson());
    if (perpus != null) {
      changeTheme(perpus);
      Get.toNamed(AppRoutes.authUser, arguments: perpus);
    } else {
      isError.value = true;
      buttonState.value = ButtonState.disable;
    }
  }

  void changeTheme(Perpus perpus) {
    final perpusColor = getPerpusColor(perpus.color ?? "Light Blue");
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
        // child: OverlayPermissionPage(onGranted: onGranted),
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
