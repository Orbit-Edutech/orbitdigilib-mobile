import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';

import '../../../api/auth/model/model_auth_perpustakaan.dart';
import '../../../shared/widget/app_button.dart';

class AuthUserController extends GetxController {
  final Rx<bool> isForget = false.obs;
  final Rx<bool> isForgetSuccess = false.obs;

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

  AuthPerpustakaan? perpustakaan;

  Rx<ButtonState> loginButtonState = ButtonState.disable.obs;
  Rx<ButtonState> forgetButtonState = ButtonState.disable.obs;
  Rx<bool> isLoginError = false.obs;
  Rx<bool> isForgetError = false.obs;
  // TODO: implement error msg from API respons

  Future<void> onSubmitLogin() async {
    loginButtonState.value = ButtonState.loading;
    await Future.delayed(const Duration(seconds: 3));
    isLoginError.value = true;
    loginButtonState.value = isLoginError.value ? ButtonState.disable : ButtonState.enable;
  }

  Future<void> onSubmitForget() async {
    forgetButtonState.value = ButtonState.loading;
    await Future.delayed(const Duration(seconds: 3));
    final isSuccess = emailController.text == "bima@gmail.com";
    if (isSuccess) {
      isForgetSuccess.value = true;
      forgetButtonState.value = ButtonState.enable;
    } else {
      isForgetError.value = true;
      forgetButtonState.value = isForgetError.value ? ButtonState.disable : ButtonState.enable;
    }
  }

  void onLoginFormChange(String text) {
    if (isLoginError.value) {
      isLoginError.value = false;
      loginButtonState.value = ButtonState.enable;
    }
    final username = usernameController.text;
    final password = passwordController.text;
    final isValid = username.isNotEmpty && password.isNotEmpty;
    loginButtonState.value = isValid ? ButtonState.enable : ButtonState.disable;
  }

  void onForgetFormChange(String text) {
    if (isForgetError.value) {
      isForgetError.value = false;
      forgetButtonState.value = ButtonState.enable;
    }

    final email = emailController.text;
    final isValid = email.isEmail;
    forgetButtonState.value = isValid ? ButtonState.enable : ButtonState.disable;
  }
}
