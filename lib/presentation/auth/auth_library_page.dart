import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../shared/widget/app_button.dart';
import '../../shared/widget/app_textfield.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/responsive_helper.dart';
import 'controller/auth_library_controller.dart';

class AuthLibraryPage extends StatelessWidget {
  const AuthLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.find<AuthLibraryController>();
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxContentWidth(context),
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColor.def,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(Sizes.m),
                          bottomRight: Radius.circular(Sizes.m),
                        ),
                      ),
                      width: size.width,
                      padding: EdgeInsets.all(
                        ResponsiveHelper.getHorizontalPadding(context),
                      ),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Selamat Datang",
                              style: AppTextStyle.ts24Bold.copyWith(color: Colors.white),
                            ),
                            Text(
                              "ORBIT Digital Library",
                              style: AppTextStyle.ts16Bold.copyWith(color: Colors.white),
                            ),
                            VGap.m,
                            SvgPicture.asset(
                              "assets/illustrations/office.svg",
                              width: 200,
                            ),
                          ],
                        ),
                      ),
                    ),
                    VGap.l,
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.getHorizontalPadding(context),
                      ),
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
                            final errorText = controller.errorMessage.value;
                            final buttonState = controller.buttonState.value;
                            return AppTextField(
                              type: TextFieldType.normal,
                              controller: controller.kodeController,
                              focusNode: controller.kodeFocusNode,
                              onTapOutside: (_) => controller.kodeFocusNode.unfocus(),
                              onChanged: controller.onKodeChanged,
                              onSubmitted: (_) => controller.onSubmit(),
                              isError: isError,
                              errorText: errorText,
                              label: Text(
                                "Kode Perpustakaan",
                                style: AppTextStyle.ts14Reg,
                              ),
                              enabled: buttonState != ButtonState.loading,
                            );
                          }),
                          VGap.m,
                          Obx(() {
                            final state = controller.buttonState.value;
                            return AppButton(
                              type: ButtonType.elevated,
                              state: state,
                              backgroundColor: AppColor.def,
                              foregroundColor: Colors.white,
                              onPressed: controller.onSubmit,
                              child: const Text("Lanjut"),
                            );
                          }),
                          if (!Platform.isIOS) ...[
                            VGap.s,
                            AppButton(
                              type: ButtonType.outlined,
                              state: ButtonState.enable,
                              foregroundColor: AppColor.def,
                              borderColor: AppColor.def,
                              onPressed: controller.showRegisterInfo,
                              child: const Text("Daftar Akun"),
                            ),
                          ],
                          VGap.h,
                        ],
                      ),
                    ),
                    VGap.h,
                    Padding(
                      padding: EdgeInsets.all(
                        ResponsiveHelper.getHorizontalPadding(context),
                      ),
                      child: Column(
                        children: [
                          Image.asset("assets/logo/orbit-digilib-logo.png", width: 100),
                          VGap.s,
                          Column(
                            children: [
                              Text(
                                "Perpustakaan Digital Untuk Semua",
                                style: AppTextStyle.ts12Reg,
                              ),
                              Text(
                                "© 2024 ORBIT DIGILIB. Powered by ORBIT EDUTECH.",
                                style: AppTextStyle.ts10Reg,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
