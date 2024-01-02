import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:get/route_manager.dart';

import '../../../api/api_client.dart';
import '../../../api/auth/data/auth_forgot_password.dart';
import '../../../api/auth/data/auth_login.dart';
import '../../../api/perpustakaan/model/model_perpustakaan.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../utils/hash_string.dart';
import '../../../utils/shared_preferences_manager.dart';

class AuthUserController extends GetxController {
  final Rx<bool> isForgot = false.obs;
  final Rx<bool> isForgotSuccess = false.obs;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  Rx<bool> isObscure = true.obs;
  Rx<bool> isPasswordFocus = false.obs;
  void toggleObscure([bool? isObscure]) {
    if (isObscure != null) {
      this.isObscure.value = isObscure;
    } else {
      this.isObscure.value = !this.isObscure.value;
    }
  }

  void setPasswordFocus([bool? focus]) {
    if (focus != null) isPasswordFocus.value = focus;
  }

  @override
  void onInit() async {
    final username = await SharedPreferencesManager.readPref<String>("username");
    if (username != null) usernameController.text = username;
    super.onInit();
  }

  Perpustakaan? perpustakaan;

  Rx<ButtonState> loginButtonState = ButtonState.disable.obs;
  Rx<ButtonState> forgotButtonState = ButtonState.disable.obs;
  Rx<bool> isLoginError = false.obs;
  Rx<bool> isForgotError = false.obs;
  Rx<String> loginErrorMsg = "".obs;
  Rx<String> forgotErrorMsg = "".obs;

  Future<void> onSubmitLogin() async {
    loginButtonState.value = ButtonState.loading;
    final password = hashString(passwordController.text);
    final response = await login(
      username: usernameController.text,
      password: password,
      idPerpustakaan: perpustakaan?.id ?? "",
    );
    if (response.data != null) {
      final isMember = response.data?.user?.role?.nama == "Anggota";
      if (isMember) {
        final token = response.data!.token!;
        final prefs = {
          "isLogin": true,
          "access": token.accessToken,
          "refresh": token.refreshToken,
          "username": usernameController.text,
          "kodePerpustakaan": perpustakaan!.kode,
          "idPerpustakaan": perpustakaan!.id,
          "color": perpustakaan!.warnaDasar,
        };
        SharedPreferencesManager.writePrefs(prefs);
        Get.offAllNamed(AppRoutes.navigator);
      } else {
        isLoginError.value = true;
        loginErrorMsg.value = "Aplikasi khusus Anggota Perpustakaan";
        loginButtonState.value = ButtonState.disable;
      }
    } else {
      if (response.error == ResponseStatus.connectionError) {
        loginErrorMsg.value = "Kesalahan koneksi";
      } else {
        loginErrorMsg.value = response.error["message"].toString();
      }
      isLoginError.value = true;
      loginButtonState.value = ButtonState.disable;
    }
  }

  Future<void> onSubmitForgot() async {
    forgotButtonState.value = ButtonState.loading;
    final response = await forgotPassword(emailController.text);
    if (response.data != null) {
      isForgotSuccess.value = true;
      forgotButtonState.value = ButtonState.enable;
    } else {
      forgotErrorMsg.value = response.error["message"];
      isForgotError.value = true;
      forgotButtonState.value = isForgotError.value ? ButtonState.disable : ButtonState.enable;
    }
  }

  void onLoginFormChange(String text) {
    if (isLoginError.value) {
      isLoginError.value = false;
      loginErrorMsg.value = "";
      loginButtonState.value = ButtonState.enable;
    }
    final username = usernameController.text;
    final password = passwordController.text;
    final isValid = username.isNotEmpty && password.isNotEmpty;
    loginButtonState.value = isValid ? ButtonState.enable : ButtonState.disable;
  }

  void onForgotFormChange(String text) {
    if (isForgotError.value) {
      isForgotError.value = false;
      forgotErrorMsg.value = "";
      forgotButtonState.value = ButtonState.enable;
    }

    final email = emailController.text;
    final isValid = email.isEmail;
    forgotButtonState.value = isValid ? ButtonState.enable : ButtonState.disable;
  }
}
