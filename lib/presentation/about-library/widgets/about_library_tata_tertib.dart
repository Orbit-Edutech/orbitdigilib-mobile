import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_path.dart';
import '../../../theme/app_text_stlye.dart';
import '../../../constants/gaps.dart';
import '../controller/about_library_controller.dart';
import '../tata_tertib_pdf_page.dart';

class AboutLibraryTataTertib extends StatelessWidget {
  const AboutLibraryTataTertib({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutLibraryController>();
    return Obx(() {
      final perpustakaan = controller.perpustakaan.value;
      final assetId = perpustakaan?.assetTataTertib?.id;
      if (assetId == null) return const SizedBox.shrink();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tata Tertib Perpustakaan", style: AppTextStyle.ts14Bold),
          VGap.s,
          ElevatedButton.icon(
            onPressed: () {
              final url = APIPath.publicAsset(assetId);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TataTertibPdfPage(url: url),
                ),
              );
            },
            icon: const Icon(Icons.picture_as_pdf),
            label: const Text("Lihat Tata Tertib"),
          ),
          VGap.m,
        ],
      );
    });
  }
}
