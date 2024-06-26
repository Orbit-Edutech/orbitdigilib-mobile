import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../../constants/gaps.dart';
import '../../../theme/app_color.dart';
import '../controller/offline_read_controller.dart';

class OfflineReadAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OfflineReadAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<OfflineReadController>();
    const isSample = false;
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
              actions: [
                if (!controller.isOnSearch.value && !isSample)
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
                    ];
                  },
                  onSelected: (value) {
                    switch (value) {
                      case 1:
                        controller.showPageSearchDiaog();
                        break;
                      case 2:
                        controller.goToLastPageSeen();
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
