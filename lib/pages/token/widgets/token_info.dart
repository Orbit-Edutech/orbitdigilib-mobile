import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class TokenInfo extends StatelessWidget {
  const TokenInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final options = [
      {"name": "Perpustakaan", "logo": "assets/icons/icon.png"},
      {"name": "Orbit360", "logo": "assets/icons/icon.png"},
      {"name": "Tokopedia", "logo": "assets/icons/icon.png"},
      {"name": "Shopee", "logo": "assets/icons/icon.png"},
      {"name": "BukaLapak", "logo": "assets/icons/icon.png"},
      {"name": "Instagram Orbit", "logo": "assets/icons/icon.png"},
      {"name": "Mitra Satu", "logo": "assets/icons/icon.png"},
      {"name": "Mitra Dua", "logo": "assets/icons/icon.png"},
      {"name": "Mitra Tiga", "logo": "assets/icons/icon.png"}
    ];
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.topCenter,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // TODO: Cek revisi dari Pak Zaky di figma 8 Des 2024
          Text(
            "Anda bisa mendapatkan Voucher Token DIGILIB melalui beberapa platform dibawah",
            style: AppTextStyle.ts14Reg,
          ),
          VGap.r,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (var option in options) ...[
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: Sizes.s, horizontal: Sizes.r),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
                          border: Border.all(color: AppColor.lightGrey, width: 1),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(Sizes.xs)),
                                image: DecorationImage(
                                  image: AssetImage(option["logo"].toString()),
                                ),
                              ),
                            ),
                            HGap.r,
                            Text(option['name'].toString(), style: AppTextStyle.ts14Reg),
                            const Spacer(),
                            Icon(Icons.arrow_forward_ios_rounded, color: theme.primaryColor),
                          ],
                        ),
                      ),
                    ),
                    VGap.s,
                  ]
                ],
              ),
            ),
          ),
          VGap.s,
          AppButton(
            type: ButtonType.outlined,
            onPressed: Get.back,
            child: Text(
              "Batal",
              style: AppTextStyle.ts14Bold,
            ),
          )
        ],
      ),
    );
  }
}
