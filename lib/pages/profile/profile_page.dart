import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_info.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/compute_luminance.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(Sizes.m),
                  bottomRight: Radius.circular(Sizes.m),
                ),
              ),
              width: size.width,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.sm, vertical: Sizes.s),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Akun",
                            style: AppTextStyle.ts20Bold.copyWith(color: calculateLuminance(theme.primaryColor)),
                          ),
                          SvgPicture.asset(
                            "assets/icons/notifications-unread.svg",
                            height: 20,
                            width: 24,
                          ),
                        ],
                      ),
                      VGap.m,
                      Row(
                        children: [
                          Image.asset(
                            "assets/icons/icon.png",
                            width: Sizes.xh,
                          ),
                          HGap.r,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Selamat Datang,",
                                style: AppTextStyle.ts12CBold.copyWith(
                                  color: calculateLuminance(theme.primaryColor),
                                ),
                              ),
                              Text(
                                "Nama Anggota",
                                style: AppTextStyle.ts18Bold.copyWith(
                                  color: calculateLuminance(theme.primaryColor),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      VGap.m,
                    ],
                  ),
                ),
              ),
            ),
            VGap.r,
            Column(
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
                  onTap: () {},
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
                  icon: const Icon(Icons.info_outline_rounded),
                  title: "Tentang Aplikasi",
                  subTitle: "v${AppInfo.version}",
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SettingCard extends StatelessWidget {
  const SettingCard({
    super.key,
    required this.icon,
    required this.title,
    this.subTitle,
    required this.onTap,
  });

  final Widget icon;
  final String title;
  final String? subTitle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.r),
        child: Row(
          children: [
            icon,
            HGap.m,
            Text(title, style: AppTextStyle.ts14Bold),
            const Spacer(),
            if (subTitle != null) ...[
              Text(
                subTitle!,
                style: AppTextStyle.ts10Reg.copyWith(color: AppColor.grey),
              ),
              HGap.m,
            ],
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: Sizes.sr,
              color: AppColor.grey,
            ),
          ],
        ),
      ),
    );
  }
}
