import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../constants/app_info.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import 'profile_settings_card.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.s),
              child: Text(
                "PENGATURAN AKUN",
                style: AppTextStyle.ts12Bold.copyWith(color: AppColor.grey),
              ),
            ),
            VGap.s,
            SettingCard(
              icon: const Icon(Icons.settings_outlined),
              title: "Keamanan Akun",
              onTap: () => Get.toNamed(AppRoutes.resetPassword),
            ),
            SettingCard(
              icon: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: AppColor.black),
                ),
                child: const Icon(Icons.question_mark_rounded, size: 20),
              ),
              title: "Pusat Bantuan",
              onTap: () {},
            ),
            SettingCard(
              icon: const Icon(Icons.library_books_outlined),
              title: "Tentang Perpustakaan",
              onTap: () {},
            ),
            SettingCard(
              icon: const Icon(Icons.info_outline_rounded),
              title: "Tentang Aplikasi",
              subTitle: "v${AppInfo.version}",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
