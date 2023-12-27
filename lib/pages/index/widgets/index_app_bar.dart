import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/gaps.dart';
import '../../../theme/app_text_stlye.dart';
import '../../../utils/compute_luminance.dart';

class IndexAppBar extends StatefulWidget implements PreferredSizeWidget {
  const IndexAppBar({
    super.key,
  });

  @override
  State<IndexAppBar> createState() => _IndexAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(54);
}

class _IndexAppBarState extends State<IndexAppBar> {
  bool isRead = false;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: theme.primaryColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          HGap.s,
          Expanded(
            child: Text(
              "Perpustakaan Orbit",
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.ts18Bold.copyWith(
                color: calculateLuminance(theme.primaryColor),
              ),
            ),
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.search_rounded,
            color: calculateLuminance(theme.primaryColor),
            size: 24,
          ),
        ),
        HGap.r,
        GestureDetector(
          onTap: () => setState(() => isRead = !isRead),
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
