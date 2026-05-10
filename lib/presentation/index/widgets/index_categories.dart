import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart";
import "package:get/instance_manager.dart";
import "package:get/route_manager.dart";

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/empty_list.dart';
import '../../../theme/app_text_stlye.dart';
import '../../../utils/responsive_helper.dart';
import "../controller/index_controller.dart";
import "index_category_card.dart";

class IndexCategories extends StatelessWidget {
  const IndexCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final crossAxisCount = ResponsiveHelper.getCrossAxisCount(
      context,
      mobile: 4,
      tablet: 6,
      desktop: 8,
    );
    final controller = Get.find<IndexController>();
    return Obx(() {
      if (controller.categories.value == null) return const SizedBox();
      final categories = controller.categories.value;
      final maxDisplayCount = crossAxisCount - 1;
      final isMoreThanMax = categories!.length > maxDisplayCount;
      return Container(
        margin: const EdgeInsets.symmetric(vertical: Sizes.s),
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VGap.r,
            Text(
              "Katalog Buku",
              style: AppTextStyle.ts14Bold,
            ),
            VGap.r,
            if (categories.isEmpty) ...[
              const EmptyList(description: "Katalog buku masih kosong"),
            ] else ...[
              AlignedGridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 0,
                mainAxisSpacing: Sizes.xs,
                itemCount: isMoreThanMax ? crossAxisCount : categories.length,
                itemBuilder: (BuildContext context, int index) {
                  categories.sort((a, b) => a.urutanDitampilkan?.compareTo(b.urutanDitampilkan ?? 0) ?? 0);
                  if (index == maxDisplayCount && isMoreThanMax) {
                    return IndexCategoryCard(
                      path: "assets/icons/all-category.svg",
                      name: "Semua",
                      onTap: controller.showCategories,
                    );
                  }
                  final category = categories[index];
                  return IndexCategoryCard(
                    path: category.icon?.id ?? "-",
                    name: category.nama ?? "-",
                    onTap: () => Get.toNamed(AppRoutes.category, arguments: category),
                  );
                },
              ),
            ]
          ],
        ),
      );
    });
  }
}
