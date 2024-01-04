import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';

import '../../../constants/gaps.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_text_stlye.dart';
import '../controller/index_controller.dart';

class IndexAppBar extends StatefulWidget implements PreferredSizeWidget {
  const IndexAppBar({
    super.key,
  });

  @override
  State<IndexAppBar> createState() => _IndexAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _IndexAppBarState extends State<IndexAppBar> {
  bool isRead = false;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<IndexController>();
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          HGap.s,
          Expanded(
            child: Obx(() {
              final nama = controller.perpustakaan.value?.nama;
              return Text(
                nama ?? "-",
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.ts18Bold,
              );
            }),
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.search),
          child: const Icon(Icons.search_rounded, size: 24),
        ),
        HGap.r,
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.notifications),
          child: isRead
              ? SvgPicture.asset(
                  "assets/icons/notifications.svg",
                  height: 20,
                  width: 24,
                )
              : SvgPicture.asset(
                  "assets/icons/notifications-unread.svg",
                  height: 20,
                  width: 24,
                ),
        ),
        HGap.m,
      ],
    );
  }
}
