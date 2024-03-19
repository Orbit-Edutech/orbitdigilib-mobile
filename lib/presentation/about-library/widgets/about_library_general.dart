import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../../api/api_path.dart';
import '../../../constants/gaps.dart';
import '../../../theme/app_text_stlye.dart';
import '../controller/about_library_controller.dart';

class AboutLibraryGeneral extends StatelessWidget {
  const AboutLibraryGeneral({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutLibraryController>();
    final size = MediaQuery.of(context).size;
    return Obx(() {
      final perpustakaan = controller.perpustakaan.value;
      if (perpustakaan == null) return const SizedBox();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            APIPath.publicAsset(perpustakaan.assetLogo?.id ?? "-"),
            width: size.width / 3,
          ),
          VGap.s,
          Text(perpustakaan.nama ?? "-", style: AppTextStyle.ts24Bold),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ID PERPUSTAKAAN : 2323XXXXXX", style: AppTextStyle.ts12Reg),
            ],
          ),
          VGap.r,
          Text(
            perpustakaan.deskripsi ?? "-",
            style: AppTextStyle.ts10Light,
            textAlign: TextAlign.justify,
          ),
        ],
      );
    });
  }
}
