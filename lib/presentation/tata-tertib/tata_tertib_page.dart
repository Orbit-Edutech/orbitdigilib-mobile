import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/responsive_helper.dart';
import 'controller/tata_tertib_controller.dart';

class TataTertibPage extends StatelessWidget {
  const TataTertibPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tata Tertib Perpustakaan"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxContentWidth(context),
          ),
          child: Obx(() {
            final controller = Get.find<TataTertibController>();
            final perpustakaan = controller.perpustakaan.value;

            if (perpustakaan == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final tataTertib = perpustakaan.tataTertib;

            if (tataTertib == null || tataTertib.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.article_outlined,
                        size: 64,
                        color: AppColor.grey.withValues(alpha: 0.5),
                      ),
                      VGap.r,
                      Text(
                        "Tata tertib belum tersedia",
                        style: AppTextStyle.ts14Reg.copyWith(color: AppColor.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(
                ResponsiveHelper.getHorizontalPadding(context),
              ),
              child: Text(
                tataTertib,
                style: AppTextStyle.ts14Reg,
                textAlign: TextAlign.justify,
              ),
            );
          }),
        ),
      ),
    );
  }
}
