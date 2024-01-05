import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../../api/api_path.dart';
import '../../../api/kategori-perpus/model/model_kategori_perpus_all.dart' as k;
import '../../../constants/gaps.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import '../controller/books_controller.dart';

class BooksCategoryCard extends StatelessWidget {
  const BooksCategoryCard({
    super.key,
    required this.kategori,
  });

  final k.KategoriBukuPerpustakaan kategori;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BooksController>();
    final theme = Theme.of(context);
    return Obx(() {
      final filters = controller.filters;
      final isSelected = filters.contains(kategori.nama);
      debugPrint(isSelected.toString());
      return InkWell(
        onTap: () => controller.filter(kategori.nama!),
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
                Image.network(
                  APIPath.publicAsset(kategori.icon?.id ?? "-"),
                  width: 24,
                  height: 24,
                  color: theme.primaryColor,
                ),
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
    });
  }
}
