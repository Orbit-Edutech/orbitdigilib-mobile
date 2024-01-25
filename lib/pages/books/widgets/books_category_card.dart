import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../api/api_path.dart';
import '../../../api/kategori-perpus/model/model_kategori_perpus_all.dart' as k;
import '../../../constants/gaps.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class BooksCategoryCard extends StatelessWidget {
  const BooksCategoryCard({
    super.key,
    required this.kategori,
    required this.filter,
    required this.filters,
  });

  final k.KategoriBukuPerpustakaan kategori;
  final Function(String) filter;
  final List<String> filters;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelected = filters.contains(kategori.nama);
    return InkWell(
      onTap: () => filter(kategori.nama!),
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
              if (kategori.nama == "Lainnya") ...[
                Icon(
                  Icons.more_vert_rounded,
                  color: theme.primaryColor,
                )
              ] else ...[
                Image.network(
                  APIPath.publicAsset(kategori.icon?.id ?? "-"),
                  width: 24,
                  height: 24,
                  color: theme.primaryColor,
                ),
              ]
            ],
          ),
          VGap.xs,
          Text(
            kategori.nama ?? "-",
            style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
