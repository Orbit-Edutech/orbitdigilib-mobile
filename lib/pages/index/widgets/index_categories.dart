import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart";
import "package:get/instance_manager.dart";
import "package:get/route_manager.dart";

import "../../../constants/gaps.dart";
import "../../../constants/sizes.dart";
import "../../../routes/app_routes.dart";
import "../../../shared/widget/empty_list.dart";
import "../../../theme/app_text_stlye.dart";
import "../controller/index_controller.dart";
import "index_category_card.dart";

class IndexCategories extends StatelessWidget {
  const IndexCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width >= 600;
    final controller = Get.find<IndexController>();
    return Obx(() {
      if (controller.categories.value == null) return const SizedBox();
      final categories = controller.categories.value;
      final isMoreThan7 = categories!.length > 7;
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.s),
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
                crossAxisCount: isWide ? 8 : 4,
                crossAxisSpacing: 0,
                mainAxisSpacing: Sizes.xs,
                itemCount: isMoreThan7 ? 8 : categories.length,
                itemBuilder: (BuildContext context, int index) {
                  final category = categories[index];
                  if (index == 7) {
                    return IndexCategoryCard(
                      path: "assets/icons/all-category.svg",
                      name: "Semua",
                      onTap: controller.showCategories,
                    );
                  }
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
