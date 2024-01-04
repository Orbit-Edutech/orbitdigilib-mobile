import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../constants/sizes.dart';

void showSnackbar({String? title, required String message, required Color backgroundColor}) async {
  final snackbar = GetSnackBar(
    title: title,
    message: message,
    isDismissible: false,
    duration: const Duration(seconds: 5),
    animationDuration: const Duration(milliseconds: 200),
    snackPosition: SnackPosition.TOP,
    backgroundColor: backgroundColor,
    margin: const EdgeInsets.all(Sizes.m),
    borderRadius: Sizes.sr,
  );
  await Get.closeCurrentSnackbar();
  Get.showSnackbar(snackbar);
}
