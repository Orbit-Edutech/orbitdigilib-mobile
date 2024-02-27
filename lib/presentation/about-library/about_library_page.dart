import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import 'controller/about_library_controller.dart';
import 'widgets/about_library_contact.dart';
import 'widgets/about_library_footer.dart';
import 'widgets/about_library_general.dart';

class AboutLibraryPage extends StatelessWidget {
  const AboutLibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tentang Perpustakaan"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Sizes.m),
        child: Obx(() {
          final controller = Get.find<AboutLibraryController>();
          final perpustakaan = controller.perpustakaan.value;
          return Opacity(
            opacity: perpustakaan == null ? 0 : 1,
            child: const Column(
              children: [
                AboutLibraryGeneral(),
                VGap.m,
                AboutLibraryContact(),
                VGap.h,
                AboutLibraryFooter(),
              ],
            ),
          );
        }),
      ),
    );
  }
}
