import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../api/api_path.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class IndexCategoryCard extends StatelessWidget {
  const IndexCategoryCard({
    super.key,
    required this.path,
    required this.name,
    required this.onTap,
  });

  final String path;
  final String name;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/category-bg.svg",
                width: 56,
                height: 56,
                colorFilter: ColorFilter.mode(
                  name == "Semua" ? theme.primaryColor : theme.colorScheme.primaryContainer.withOpacity(.25),
                  BlendMode.srcIn,
                ),
              ),
              if (path.split(".").last.contains("svg"))
                SvgPicture.asset(
                  path,
                  width: 24,
                  height: 24,
                )
              else
                Image.network(
                  APIPath.publicAsset(path),
                  width: 24,
                  height: 24,
                  color: theme.primaryColor,
                ),
            ],
          ),
          VGap.xs,
          Text(
            name,
            style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
