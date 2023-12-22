import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/app_textfield.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import '../../../theme/app_theme.dart';
import '../controller/auth_user_controller.dart';

class AuthLoginForm extends StatelessWidget {
  const AuthLoginForm({super.key, required this.controller});

  final AuthUserController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          "Selamat Datang di Aplikasi Perpustakaan",
          style: AppTextStyle.ts14Bold,
          textAlign: TextAlign.center,
        ),
        VGap.xs,
        Text(
          "Silakan login untuk memulai perjalanan menjelajah berbagai macam literasi dari generasi ke generasi.",
          style: AppTextStyle.ts10Light.copyWith(color: AppColor.grey),
          textAlign: TextAlign.center,
        ),
        VGap.r,
        Obx(() {
          final isError = controller.isLoginError.value;
          final isObscure = controller.isObscure.value;
          final isFocus = controller.isPasswordFocus.value;
          return Column(
            children: [
              Obx(() {
                final isLoading = controller.loginButtonState.value == ButtonState.loading;
                final errorMsg = controller.loginErrorMsg.value;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextField(
                      type: TextFieldType.normal,
                      controller: controller.usernameController,
                      focusNode: controller.usernameFocusNode,
                      onTapOutside: (_) => controller.usernameFocusNode.unfocus(),
                      onChanged: controller.onLoginFormChange,
                      enabled: !isLoading,
                      isError: isError,
                      errorText: "",
                      label: Text(
                        "Username",
                        style: AppTextStyle.ts14Reg,
                      ),
                    ),
                    VGap.r,
                    Focus(
                      onFocusChange: controller.setPasswordFocus,
                      child: AppTextField(
                        type: TextFieldType.normal,
                        controller: controller.passwordController,
                        focusNode: controller.passwordFocusNode,
                        onTapOutside: (_) => controller.passwordFocusNode.unfocus(),
                        onChanged: controller.onLoginFormChange,
                        enabled: !isLoading,
                        isError: isError,
                        errorText: errorMsg,
                        isObscure: isObscure,
                        suffix: GestureDetector(
                          onTap: controller.toggleObscure,
                          child: Icon(
                            isObscure ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                            color: isError
                                ? Colors.red.shade800
                                : isFocus && !isLoading
                                    ? theme.primaryColor
                                    : AppColor.lightGrey,
                          ),
                        ),
                        label: Text(
                          "Password",
                          style: AppTextStyle.ts14Reg,
                        ),
                      ),
                    ),
                  ],
                );
              }),
              GestureDetector(
                onTap: () => controller.isForgot.value = true,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(Sizes.s),
                  child: Text(
                    "Lupa password?",
                    style: AppTextStyle.ts10Reg.copyWith(color: theme.primaryColor),
                  ),
                ),
              )
            ],
          );
        }),
        VGap.m,
        Obx(() {
          final state = controller.loginButtonState.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppButton(
                type: ButtonType.elevated,
                state: state,
                onPressed: controller.onSubmitLogin,
                child: const Text("Masuk"),
              ),
              AppButton(
                type: ButtonType.outlined,
                state: state == ButtonState.disable ? ButtonState.enable : state,
                onPressed: () {
                  AppTheme.changePerpusTheme();
                  Get.offAllNamed(AppRoutes.authLibrary);
                },
                child: const Text("Kembali"),
              ),
            ],
          );
        }),
        VGap.h,
      ],
    );
  }
}
