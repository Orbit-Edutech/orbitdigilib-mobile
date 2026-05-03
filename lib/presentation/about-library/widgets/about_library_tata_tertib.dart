import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/gaps.dart';
import '../../../theme/app_text_stlye.dart';
import '../controller/about_library_controller.dart';

class AboutLibraryTataTertib extends StatelessWidget {
  const AboutLibraryTataTertib({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutLibraryController>();
    return Obx(() {
      final tataTertib = controller.perpustakaan.value?.tataTertib;
      if (tataTertib == null || tataTertib.isEmpty) return const SizedBox.shrink();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tata Tertib Perpustakaan", style: AppTextStyle.ts14Bold),
          VGap.s,
          SelectableText(tataTertib, style: AppTextStyle.ts12Reg),
          VGap.m,
        ],
      );
    });
  }
}
