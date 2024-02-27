import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../api/auth/data/auth_change_password.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';
import '../../../utils/hash_string.dart';
import '../../../utils/shared_preferences_manager.dart';

class ChangePasswordController extends GetxController {
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final conPassController = TextEditingController();

  final oldPassFN = FocusNode();
  final newPassFN = FocusNode();
  final conPassFN = FocusNode();

  Rx<String> focus = "".obs;
  set setFocus(String focus) => this.focus.value = focus;

  Rx<ButtonState> buttonState = ButtonState.disable.obs;
  Rx<bool> isError = false.obs;
  Rx<String> errorMsg = "".obs;

  Rx<bool> isOldPassObscure = true.obs;
  Rx<bool> isNewPassObscure = true.obs;
  Rx<bool> isConPassObscure = true.obs;

  void onFormChange(String text) {
    if (isError.value) {
      isError.value = false;
      errorMsg.value = "";
      buttonState.value = ButtonState.enable;
    }
    // TOOD: pass baru gaboleh sama dengan pass lama
    final oldPass = oldPassController.text;
    final newPass = newPassController.text;
    final conPass = conPassController.text;
    final isValid =
        oldPass.isNotEmpty && newPass.isNotEmpty && conPass.isNotEmpty && newPass == conPass && oldPass != newPass;
    buttonState.value = isValid ? ButtonState.enable : ButtonState.disable;
  }

  Future<void> resetPassword() async {
    buttonState.value = ButtonState.loading;
    String oldPass = hashString(oldPassController.text);
    String newPass = hashString(newPassController.text);
    final response = await changePassword(oldPass: oldPass, newPass: newPass);
    if (response.data != null) {
      showSnackbar(message: "Berhasil mengganti Password", backgroundColor: AppColor.green);
      final accessToken = response.data?.token?.accessToken ?? "";
      SharedPreferencesManager.writePref("access", accessToken);
      buttonState.value = ButtonState.enable;
      Get.back();
    } else {
      isError.value = true;
      errorMsg.value = response.error["message"];
      buttonState.value = ButtonState.disable;
    }
  }
}
