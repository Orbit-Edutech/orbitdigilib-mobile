import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../api/api_client.dart';
import '../../../api/auth/data/auth_logout.dart' as auth;
import '../../../api/auth/data/auth_profile.dart';
import '../../../api/auth/model/model_auth_profile.dart';
import '../../../constants/sizes.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/shared_preferences_manager.dart';
import '../widgets/profile_logout_dialog.dart';

class ProfileController extends GetxController {
  Rx<AuthProfile?> profile = Rx<AuthProfile?>(null);

  Rx<ButtonState> logoutButtonState = ButtonState.enable.obs;

  @override
  Future onInit() async {
    final response = await authProfile();
    if (response.data != null) {
      profile.value = response.data;
    } else {
      if (response.error == ResponseStatus.connectionError) {
        showSnackbar(backgroundColor: AppColor.red, message: "Terjadi kesalahan koneksi");
      } else {
        showSnackbar(
            backgroundColor: AppColor.red, title: "Error ${response.statusCode}", message: response.error["message"]);
      }
    }
    super.onInit();
  }

  void showLogoutDialog() {
    Get.bottomSheet(
      const ProfileLogoutDialog(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.r)),
      ),
      isScrollControlled: true,
      enableDrag: false,
    );
  }

  Future<void> logout() async {
    logoutButtonState.value = ButtonState.loading;
    await auth.logout().then((res) {
      if (res.data != null) {
        log(res.data.toString());
      } else {
        log(res.error.toString());
      }
    });
    final prefs = {
      "isLogin": false,
      "access": "",
      "refresh": "",
    };
    await AppTheme.changePerpusTheme();
    await SharedPreferencesManager.writePrefs(prefs);
    logoutButtonState.value = ButtonState.enable;
    Get.offAllNamed(AppRoutes.authLibrary);
  }
}
