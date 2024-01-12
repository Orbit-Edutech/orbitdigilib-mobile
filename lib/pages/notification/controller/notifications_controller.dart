import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../constants/sizes.dart';
import '../../../shared/widget/app_button.dart';

class NotificationsController extends GetxController {
  void showMarkAsReadDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Apa Anda yakin?"),
        content: const Text("Seluruh notifikasi akan ditandai telah dibaca setelah ini"),
        actions: [
          AppButton(
            type: ButtonType.text,
            onPressed: Get.back,
            child: const Text("Batal"),
          ),
          AppButton(
            type: ButtonType.elevated,
            padding: const EdgeInsets.symmetric(vertical: Sizes.sr, horizontal: Sizes.m),
            onPressed: () {},
            child: const Text("Ya"),
          ),
        ],
      ),
    );
  }
}
