import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../../constants/gaps.dart';
import '../../../theme/app_text_stlye.dart';
import '../controller/about_library_controller.dart';

class AboutLibraryContact extends StatelessWidget {
  const AboutLibraryContact({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutLibraryController>();
    return Obx(() {
      final perpustakaan = controller.perpustakaan.value;
      if (perpustakaan == null) return const SizedBox();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Hubungi Kami", style: AppTextStyle.ts14Bold),
          VGap.s,
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tahun Berdiri", style: AppTextStyle.ts10Bold),
                    Text("${perpustakaan.tahunBerdiri ?? "-"}", style: AppTextStyle.ts10Reg),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nomor Telepon", style: AppTextStyle.ts10Bold),
                    Text((perpustakaan.noTelepon ?? "").replaceRange(3, null, "x" * (perpustakaan.noTelepon!.length - 3)),
                        style: AppTextStyle.ts10Reg),
                  ],
                ),
              ),
            ],
          ),
          VGap.s,
          Text("Alamat Perpustakaan", style: AppTextStyle.ts10Bold),
          Text(
            "Jl. Kemang Sel. No.98, RT.11/RW.4, Cilandak Tim., Ps. Minggu, Kota Jakarta Selatan, Daerah Khusus Ibukota Jakarta 12560",
            style: AppTextStyle.ts10Reg,
          ),
        ],
      );
    });
  }
}
