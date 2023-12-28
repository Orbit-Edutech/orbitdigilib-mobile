import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:flutter_svg/svg.dart";
import "package:get/instance_manager.dart";
import "package:get/route_manager.dart";

import "../../../constants/gaps.dart";
import "../../../constants/sizes.dart";
import "../../../shared/widget/app_button.dart";
import "../../../theme/app_color.dart";
import "../../../theme/app_text_stlye.dart";
import "../controller/index_controller.dart";

class IndexCategories extends StatelessWidget {
  const IndexCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final _ = Get.find<IndexController>();
    List<String> categories = [
      "agama",
      "anak",
      "budaya",
      "fiksi",
      "hankam",
      "hobby",
      "hukum",
      "humaniora",
      "kamus",
      "keluarga",
      "kesehatan",
      "ketrampilan-khusus",
      "komik",
      "lifestyle",
      "medis",
      "pendidikan",
      "politik",
      "psikologi",
      "sains",
      "sastra",
      "sejarah",
      "seni-design",
      "sosial",
      "teknik"
    ];
    final isMoreThan7 = categories.length > 7;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.s),
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VGap.r,
          Text(
            "Kategori Buku",
            style: AppTextStyle.ts14Bold,
          ),
          VGap.r,
          AlignedGridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            crossAxisCount: 4,
            crossAxisSpacing: 0,
            mainAxisSpacing: Sizes.xs,
            itemCount: isMoreThan7 ? 8 : categories.length,
            itemBuilder: (BuildContext context, int index) {
              final category = categories[index];
              if (index == 7) {
                return GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      SizedBox(
                        height: Get.size.height * 0.6,
                        width: Get.size.width,
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
                                "Kategori Buku",
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
                                    final cat = categories[idx];
                                    return Column(
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
                                            Image.asset(
                                              "assets/icons/kategori/$cat.png",
                                              width: 24,
                                              height: 24,
                                              color: theme.primaryColor,
                                            ),
                                          ],
                                        ),
                                        VGap.xs,
                                        Text(
                                          cat,
                                          style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
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
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.r)),
                      ),
                      isScrollControlled: true,
                      enableDrag: false,
                    );
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
                              theme.primaryColor,
                              BlendMode.srcIn,
                            ),
                          ),
                          SvgPicture.asset(
                            "assets/icons/all-category.svg",
                            width: 24,
                            height: 24,
                          ),
                        ],
                      ),
                      VGap.xs,
                      Text(
                        "Semua",
                        style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                      )
                    ],
                  ),
                );
              }
              return Column(
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
                      Image.asset(
                        "assets/icons/kategori/$category.png",
                        width: 24,
                        height: 24,
                        color: theme.primaryColor,
                      ),
                    ],
                  ),
                  VGap.xs,
                  Text(
                    category,
                    style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
