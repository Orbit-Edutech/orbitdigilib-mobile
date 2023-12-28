import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';

import '../../../constants/gaps.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_text_stlye.dart';

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
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          HGap.s,
          Expanded(
            child: Text(
              "Perpustakaan Orbit",
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.ts18Bold,
            ),
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
