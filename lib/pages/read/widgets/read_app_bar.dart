import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../../constants/gaps.dart';
import '../../../theme/app_color.dart';
import '../controller/read_controller.dart';

class ReadAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ReadAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReadController>();
    final ThemeData theme = Theme.of(context);
    return Obx(() {
      final isFullScreen = controller.isFullScreen.value;
      return Container(
        color: theme.primaryColor,
        child: SafeArea(
          child: AnimatedContainer(
            height: isFullScreen ? 0 : kToolbarHeight,
            duration: const Duration(milliseconds: 150),
            child: AppBar(
              title: const Text("Baca Buku"),
              actions: [
                if (!controller.isOnSearch.value)
                  IconButton(
                    onPressed: () {
                      controller.isOnSearch.value = true;
                      controller.isFullScreen.value = true;
                    },
                    icon: const Icon(Icons.search_rounded),
                  ),
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(Icons.manage_search_sharp, color: AppColor.black),
                            HGap.s,
                            Text("Menuju halaman"),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 2,
                        child: Row(
                          children: [
                            Icon(Icons.book_outlined, color: AppColor.black),
                            HGap.s,
                            Text("Terakhir Dibaca"),
                          ],
                        ),
                      ),
                      const PopupMenuItem(
                        value: 3,
                        child: Row(
                          children: [
                            Icon(Icons.hotel_class_outlined, color: AppColor.black),
                            HGap.s,
                            Text("Bintangi Halaman"),
                          ],
                        ),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    switch (value) {
                      case 1:
                        controller.showPageSearchDiaog();
                        break;
                      case 2:
                        break;
                      case 3:
                        break;
                    }
                  },
                  surfaceTintColor: AppColor.white,
                  color: AppColor.white,
                  icon: const Icon(Icons.menu_rounded),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
