import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../constants/gaps.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/app_textfield.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import '../controller/auth_user_controller.dart';

class AuthForgotForm extends StatelessWidget {
  const AuthForgotForm({super.key, required this.controller});

  final AuthUserController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSuccess = controller.isForgotSuccess.value;
      return isSuccess
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Permintaan Reset Password Berhasil!",
                  style: AppTextStyle.ts16Bold,
                  textAlign: TextAlign.center,
                ),
                VGap.s,
                Text(
                  "Kami telah mengirimkan informasi mengenai reset password untuk akun Anda, silahkan periksa kotak pesan email Anda.",
                  style: AppTextStyle.ts12Reg,
                  textAlign: TextAlign.center,
                ),
                VGap.m,
                AppButton(
                  type: ButtonType.outlined,
                  onPressed: () {
                    controller.isForgotSuccess.value = false;
                    controller.isForgot.value = false;
                  },
                  child: const Text("Kembali"),
                ),
              ],
            )
          : Column(
              children: [
                Text(
                  "Lupa Password",
                  style: AppTextStyle.ts14Bold,
                  textAlign: TextAlign.center,
                ),
                VGap.xs,
                Text(
                  "Jangan panik, lakukan sesuai instruksi yang diperintah.",
                  style: AppTextStyle.ts10Light.copyWith(color: AppColor.grey),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Tolong masukan email Anda.",
                  style: AppTextStyle.ts10Light.copyWith(color: AppColor.grey),
                  textAlign: TextAlign.center,
                ),
                VGap.r,
                Obx(() {
                  final isError = controller.isForgotError.value;
                  final isLoading = controller.forgotButtonState.value == ButtonState.loading;
                  final errorMessage = controller.forgotErrorMsg.value;
                  final isValid = controller.forgotButtonState.value == ButtonState.enable;
                  return AppTextField(
                    type: TextFieldType.normal,
                    label: Text(
                      "Email",
                      style: AppTextStyle.ts14Reg,
                    ),
                    onChanged: controller.onForgotFormChange,
                    onSubmitted: (_) => isValid ? controller.onSubmitForgot() : null,
                    controller: controller.emailController,
                    focusNode: controller.emailFocusNode,
                    enabled: !isLoading,
                    isError: isError,
                    errorText: errorMessage,
                  );
                }),
                VGap.xh,
                Obx(() {
                  final state = controller.forgotButtonState.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppButton(
                        type: ButtonType.elevated,
                        state: state,
                        onPressed: controller.onSubmitForgot,
                        child: const Text("Kirim"),
                      ),
                      VGap.s,
                      AppButton(
                        type: ButtonType.outlined,
                        state: state == ButtonState.disable ? ButtonState.enable : state,
                        onPressed: () => controller.isForgot.value = false,
                        child: const Text("Kembali"),
                      ),
                    ],
                  );
                }),
              ],
            );
    });
  }
}
