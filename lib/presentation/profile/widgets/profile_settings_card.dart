import 'package:flutter/material.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({
    super.key,
    required this.icon,
    required this.title,
    this.subTitle,
    required this.onTap,
  });

  final Widget icon;
  final String title;
  final String? subTitle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.r),
        child: Row(
          children: [
            icon,
            HGap.m,
            Text(title, style: AppTextStyle.ts14Bold),
            const Spacer(),
            if (subTitle != null) ...[
              Text(
                subTitle!,
                style: AppTextStyle.ts10Reg.copyWith(color: AppColor.grey),
              ),
              HGap.m,
            ],
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: Sizes.sr,
              color: AppColor.grey,
            ),
          ],
        ),
      ),
    );
  }
}
