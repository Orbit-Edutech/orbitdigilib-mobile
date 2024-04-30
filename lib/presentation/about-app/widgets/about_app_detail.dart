import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../constants/gaps.dart';
import '../../../theme/app_text_stlye.dart';
import '../../splash/controller/splash_controller.dart';

class AboutAppDetail extends StatelessWidget {
  const AboutAppDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final validate = Get.find<SplashController>().validate;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Detail Aplikasi", style: AppTextStyle.ts14Bold),
        VGap.s,
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Dirilis tanggal", style: AppTextStyle.ts10Bold),
                  Text("18 Maret 2024", style: AppTextStyle.ts10Reg),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Diupdate tanggal", style: AppTextStyle.ts10Bold),
                  Text(
                    "${Platform.isAndroid ? validate?.version?.android?.updatedAt : validate?.version?.iOs?.updatedAt}",
                    style: AppTextStyle.ts10Reg,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
