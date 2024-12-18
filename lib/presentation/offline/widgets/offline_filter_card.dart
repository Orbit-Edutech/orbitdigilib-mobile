import 'package:flutter/material.dart';

import '../../../constants/sizes.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class OfflineFilterCard extends StatelessWidget {
  const OfflineFilterCard({
    super.key,
    required this.text,
    required this.onTap,
    required this.isActive,
  });

  final String text;
  final Function() onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.r, vertical: Sizes.s),
        decoration: BoxDecoration(
          color: isActive ? theme.primaryColor.withOpacity(.2) : null,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
        ),
        child: Column(
          children: [
            Text(
              text,
              style: AppTextStyle.ts14Bold.copyWith(color: isActive ? theme.primaryColor : AppColor.lightGrey),
            ),
            if (isActive) ...[
              Container(
                margin: const EdgeInsets.only(top: 1),
                width: 15,
                height: 1,
                color: theme.primaryColor,
              )
            ]
          ],
        ),
      ),
    );
  }
}
