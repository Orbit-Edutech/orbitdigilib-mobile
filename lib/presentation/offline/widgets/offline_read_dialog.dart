import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/app_divider.dart';
import '../../../sql/books/model/model_buku_sql.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class OfflineReadDialog extends StatelessWidget {
  const OfflineReadDialog({
    super.key,
    required this.buku,
    required this.lastPageSeen,
    required this.totalPages,
  });

  final ModelBukuSql buku;
  final int lastPageSeen;
  final int totalPages;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .5,
      width: size.width,
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.l)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.r),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 75,
                  alignment: Alignment.bottomLeft,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      if (buku.assetSampulPath == null)
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(Sizes.s),
                          child: const Text(
                            "Sampul Kosong",
                            textAlign: TextAlign.center,
                          ),
                        )
                      else
                        Image(
                          image: FileImage(File(buku.assetSampulPath!)),
                          fit: BoxFit.cover,
                          width: 75,
                          height: 100,
                        ),
                    ],
                  ),
                ),
                HGap.s,
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(Sizes.s),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          buku.judul,
                          style: AppTextStyle.ts14Bold,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        VGap.s,
                        Text(
                          buku.penulis,
                          style: AppTextStyle.ts14Light,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        VGap.s,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.xs,
                                horizontal: Sizes.s,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(Sizes.xh),
                                ),
                                color: theme.primaryColor,
                              ),
                              child: Text(
                                buku.tipe,
                                style: AppTextStyle.ts10Bold.copyWith(
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                            HGap.xs,
                            Text(
                              "Hal - $lastPageSeen / $totalPages",
                              style: AppTextStyle.ts10Light.copyWith(color: AppColor.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const AppDivider(height: Sizes.xh),
            AppButton(
              type: ButtonType.elevated,
              onPressed: () {
                Get.back();
                Get.toNamed(AppRoutes.offlineRead, arguments: buku.idBuku);
              },
              child: const Text("Baca"),
            ),
            VGap.s,
            AppButton(
              type: ButtonType.outlined,
              onPressed: Get.back,
              child: const Text("Batal"),
            ),
          ],
        ),
      ),
    );
  }
}
