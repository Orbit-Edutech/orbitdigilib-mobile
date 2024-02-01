import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../api/api_path.dart';
import '../../../api/katalog-perpus/model/model_katalog_perpus_all.dart' as k;
import '../../../constants/gaps.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class BooksCategoryCard extends StatelessWidget {
  const BooksCategoryCard({
    super.key,
    required this.category,
    required this.filter,
    required this.categories,
  });

  final k.KatalogBukuPerpustakaan category;
  final Function(k.KatalogBukuPerpustakaan) filter;
  final List<k.KatalogBukuPerpustakaan> categories;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = categories.firstWhereOrNull((category) => this.category.nama == category.nama) != null;
    return InkWell(
      onTap: () {
        filter(category);
      },
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
                  theme.colorScheme.primaryContainer.withOpacity(isSelected ? .75 : .25),
                  BlendMode.srcIn,
                ),
              ),
              if (category.nama == "Lainnya") ...[
                Icon(
                  Icons.more_vert_rounded,
                  color: theme.primaryColor,
                )
              ] else ...[
                Image.network(
                  APIPath.publicAsset(category.icon?.id ?? "-"),
                  width: 24,
                  height: 24,
                  color: theme.primaryColor,
                ),
              ]
            ],
          ),
          VGap.xs,
          Text(
            category.nama ?? "-",
            style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
