import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';

import '../../api/model/perpus_model.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../shared/widget/app_button.dart';
import '../../shared/widget/app_textfield.dart';
import '../../theme/app_text_stlye.dart';
import '../../theme/app_theme.dart';
import 'controller/auth_user_controller.dart';

class AuthUserPage extends StatelessWidget {
  const AuthUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final Perpus? perpus = Get.arguments;
    final controller = Get.find<AuthUserController>();
    controller.perpus.value = perpus;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.m),
                  bottomRight: Radius.circular(Sizes.m),
                ),
              ),
              width: size.width,
              padding: const EdgeInsets.all(24),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                    ),
                    VGap.m,
                    Text(
                      controller.perpus.value?.name ?? "-",
                      style: AppTextStyle.ts16Bold.copyWith(color: Colors.white),
                    ),
                    VGap.m,
                  ],
                ),
              ),
            ),
            VGap.l,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Masukkan kode perpustakaan Anda",
                    style: AppTextStyle.ts10Light,
                    textAlign: TextAlign.center,
                  ),
                  VGap.r,
                  Obx(() {
                    final isError = controller.isError.value;
                    return AppTextField(
                      type: TextFieldType.normal,
                      controller: controller.usernameController,
                      focusNode: controller.usernameFocusNode,
                      onTapOutside: (_) => controller.usernameFocusNode.unfocus(),
                      onChanged: (_) => controller.resetError(),
                      isError: isError,
                      errorText: "Perpustakaan tidak ditemukan",
                      label: Text(
                        "Kode Perpustakaan",
                        style: AppTextStyle.ts14Reg,
                      ),
                    );
                  }),
                  VGap.s,
                  Container(
                    decoration: const BoxDecoration(),
                  ),
                  VGap.h,
                  AppButton(
                    type: ButtonType.elevated,
                    state: ButtonState.enable,
                    onPressed: controller.onSubmit,
                    child: const Text("Masuk"),
                  ),
                  AppButton(
                    type: ButtonType.outlined,
                    state: ButtonState.enable,
                    onPressed: () {
                      Get.changeTheme(AppTheme.theme);
                      Get.back();
                    },
                    child: const Text("Kembali"),
                  ),
                  VGap.h,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
