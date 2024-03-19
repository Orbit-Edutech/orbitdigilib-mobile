import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../../shared/widget/app_button.dart';
import '../../../theme/app_color.dart';
import '../controller/splash_controller.dart';

class SplashErrorDialog extends StatelessWidget {
  const SplashErrorDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();
    return PopScope(
      canPop: false,
      child: AlertDialog(
        backgroundColor: AppColor.white,
        title: const Text("Terjadi kesalahan"),
        content: const Text(
            'Sistem sedang dalam pemeliharaan, atau periksa koneksi Anda. Tunggu beberapa saat lalu "Muat Ulang"'),
        actions: [
          AppButton(
            type: ButtonType.text,
            onPressed: () {
              Get.back(closeOverlays: true);
              controller.onInit();
            },
            child: const Text("Muat Ulang"),
          )
        ],
      ),
    );
  }
}
