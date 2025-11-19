import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';

import '../../../api/api_path.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import '../../../utils/responsive_helper.dart';
import '../controller/books_controller.dart';

class BooksCategoryFilter extends StatelessWidget {
  const BooksCategoryFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BooksController>();
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final crossAxisCount = ResponsiveHelper.getCrossAxisCount(
      context,
      mobile: 4,
      tablet: 6,
      desktop: 8,
    );
    return SizedBox(
      height: size.height * 0.6,
      width: size.width,
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(Sizes.m),
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Sizes.l),
            topRight: Radius.circular(Sizes.l),
          ),
        ),
        child: Obx(() {
          final categories = controller.categories.value ?? [];
          final category = controller.category.value;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Katalog Buku",
                style: AppTextStyle.ts14Bold,
                textAlign: TextAlign.start,
              ),
              VGap.r,
              Expanded(
                child: AlignedGridView.count(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: Sizes.xs,
                  itemCount: categories.length,
                  itemBuilder: ((ctx, idx) {
                    final item = categories[idx];
                    final isSelected = item == category;
                    return InkWell(
                      onTap: () => controller.changeCategory(item),
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
                              CachedNetworkImage(
                                imageUrl: APIPath.publicAsset(item.icon?.id ?? "-"),
                                width: 24,
                                height: 24,
                                color: theme.primaryColor,
                              ),
                            ],
                          ),
                          VGap.xs,
                          Text(
                            item.nama ?? "-",
                            style: isSelected
                                ? AppTextStyle.ts12Bold.copyWith(color: AppColor.grey)
                                : AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
              VGap.r,
              if (category != null) ...[
                AppButton(
                  type: ButtonType.elevated,
                  onPressed: () => controller.changeCategory(null),
                  child: Text("Hapus", style: AppTextStyle.ts14Bold),
                ),
                VGap.s,
              ],
              AppButton(
                type: ButtonType.outlined,
                onPressed: Get.back,
                child: Text("Tutup", style: AppTextStyle.ts14Bold),
              ),
            ],
          );
        }),
      ),
    );
  }
}
