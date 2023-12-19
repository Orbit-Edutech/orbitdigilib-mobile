import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../constants/gaps.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/app_textfield.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import '../controller/auth_user_controller.dart';

class AuthForgetForm extends StatelessWidget {
  const AuthForgetForm({super.key, required this.controller});

  final AuthUserController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSuccess = controller.isForgetSuccess.value;
      return isSuccess
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Permintaan Ganti Password Berhasil!",
                  style: AppTextStyle.ts16Bold,
                  textAlign: TextAlign.center,
                ),
                VGap.s,
                Text(
                  "Kami telah mengirimkan informasi mengenai pergantian password untuk akun Anda, silahkan periksa kotak pesan email Anda.",
                  style: AppTextStyle.ts12Reg,
                  textAlign: TextAlign.center,
                ),
                VGap.m,
                AppButton(
                  type: ButtonType.outlined,
                  onPressed: () {
                    controller.isForgetSuccess.value = false;
                    controller.isForget.value = false;
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
                  final isError = controller.isForgetError.value;
                  final isLoading = controller.forgetButtonState.value == ButtonState.loading;
                  return AppTextField(
                    type: TextFieldType.normal,
                    label: Text(
                      "Email",
                      style: AppTextStyle.ts14Reg,
                    ),
                    onChanged: controller.onForgetFormChange,
                    controller: controller.emailController,
                    focusNode: controller.emailFocusNode,
                    enabled: !isLoading,
                    isError: isError,
                    errorText: "Email tidak ditemukan",
                  );
                }),
                VGap.xh,
                Obx(() {
                  final state = controller.forgetButtonState.value;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppButton(
                        type: ButtonType.elevated,
                        state: state,
                        onPressed: controller.onSubmitForget,
                        child: const Text("Kirim"),
                      ),
                      AppButton(
                        type: ButtonType.outlined,
                        state: state == ButtonState.disable ? ButtonState.enable : state,
                        onPressed: () => controller.isForget.value = false,
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
