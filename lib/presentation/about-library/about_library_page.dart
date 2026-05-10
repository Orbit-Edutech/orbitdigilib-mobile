import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../constants/gaps.dart';
import '../../utils/responsive_helper.dart';
import 'controller/about_library_controller.dart';
import 'widgets/about_library_contact.dart';
import 'widgets/about_library_footer.dart';
import 'widgets/about_library_general.dart';
import 'widgets/about_library_tata_tertib.dart';

class AboutLibraryPage extends StatelessWidget {
  const AboutLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tentang Perpustakaan"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxContentWidth(context),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(
              ResponsiveHelper.getHorizontalPadding(context),
            ),
            child: Obx(() {
              final controller = Get.find<AboutLibraryController>();
              final perpustakaan = controller.perpustakaan.value;
              return Opacity(
                opacity: perpustakaan == null ? 0 : 1,
                child: const Column(
                  children: [
                    AboutLibraryGeneral(),
                    VGap.m,
                    AboutLibraryTataTertib(),
                    AboutLibraryContact(),
                    VGap.h,
                    AboutLibraryFooter(),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
