import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../shared/widget/app_button.dart';
import '../../theme/app_text_stlye.dart';
import 'controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.find<SplashController>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/icon.png", width: size.width / 4),
            VGap.s,
            Image.asset("assets/icons/text-icon.png", width: size.width / 4),
            VGap.m,
            Obx(() {
              final isNoInternet = controller.isNoInternet.value;
              final buttonState = controller.buttonState.value;
              if (isNoInternet) {
                return Column(
                  children: [
                    if (buttonState != ButtonState.loading)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
                        child: Text(
                          "Terjadi permasalahan koneksi",
                          style: AppTextStyle.ts16Reg,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    AppButton(
                      state: buttonState,
                      type: ButtonType.text,
                      onPressed: controller.onInit,
                      child: const Text("Muat Ulang"),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            })
          ],
        ),
      ),
    );
  }
}
