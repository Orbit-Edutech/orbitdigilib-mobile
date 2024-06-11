import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';

import '../../../api/api_path.dart';
import '../../../api/katalog-perpus/model/model_katalog_perpus_all.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class IndexCategoriesModal extends StatelessWidget {
  const IndexCategoriesModal({
    super.key,
    required this.categories,
  });

  final List<KatalogBukuPerpustakaan> categories;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
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
        child: Column(
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
                crossAxisCount: 4,
                crossAxisSpacing: 0,
                mainAxisSpacing: Sizes.xs,
                itemCount: categories.length,
                itemBuilder: ((ctx, idx) {
                  final kategori = categories[idx];
                  return InkWell(
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.category, arguments: kategori);
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
                                theme.colorScheme.primaryContainer.withOpacity(.25),
                                BlendMode.srcIn,
                              ),
                            ),
                            CachedNetworkImage(
                              imageUrl: APIPath.publicAsset(kategori.icon?.id ?? "-"),
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
                }),
              ),
            ),
            VGap.r,
            AppButton(
              type: ButtonType.outlined,
              onPressed: Get.back,
              child: Text("Tutup", style: AppTextStyle.ts14Bold),
            ),
          ],
        ),
      ),
    );
  }
}
