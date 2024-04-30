import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../constants/app_info.dart';
import '../../constants/gaps.dart';
import '../../theme/app_text_stlye.dart';
import 'controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _ = Get.find<SplashController>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.asset("assets/logo/orbit-digilib-logo.png", width: size.width / 3)),
            Text(
              "Version ${Platform.isAndroid ? AppInfo.android.versionName : AppInfo.iOs.versionName}",
              style: AppTextStyle.ts10Reg,
            ),
            VGap.m,
          ],
        ),
      ),
    );
  }
}
