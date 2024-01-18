import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../../api/api_path.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_text_stlye.dart';
import '../../../utils/compute_luminance.dart';
import '../controller/profile_controller.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.isRead});
  final bool isRead;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final controller = Get.find<ProfileController>();
    return Container(
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
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.notifications),
                    child: isRead
                        ? SvgPicture.asset(
                            "assets/icons/notifications.svg",
                            height: 20,
                            width: 24,
                          )
                        : SvgPicture.asset(
                            "assets/icons/notifications-unread.svg",
                            height: 20,
                            width: 24,
                          ),
                  ),
                ],
              ),
              VGap.m,
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    width: 50,
                    height: 50,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(
                      APIPath.publicAsset(controller.profile.value?.urlFotoProfil ?? "550c1a88-bfe5-467f-9b3e-05abb74de218"),
                      fit: BoxFit.cover,
                    ),
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
                        controller.profile.value?.nama ?? "-",
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
    );
  }
}
