import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';
// import 'package:get/route_manager.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
// import '../../../routes/app_routes.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import '../../../utils/compute_luminance.dart';
import '../../../utils/responsive_helper.dart';
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
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveHelper.getHorizontalPadding(context),
            vertical: Sizes.s,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Akun",
                    style: AppTextStyle.ts20Bold.copyWith(
                        color: calculateLuminance(theme.primaryColor)),
                  ),
                  // TODO: Fitur notifikasi akan dikembangkan pada fase 2
                  // GestureDetector(
                  //   onTap: () => Get.toNamed(AppRoutes.notifications),
                  //   child: isRead
                  //       ? SvgPicture.asset(
                  //           "assets/icons/notifications.svg",
                  //           height: 20,
                  //           width: 24,
                  //         )
                  //       : SvgPicture.asset(
                  //           "assets/icons/notifications-unread.svg",
                  //           height: 20,
                  //           width: 24,
                  //         ),
                  // ),
                ],
              ),
              VGap.m,
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    width: 50,
                    height: 50,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Icon(
                      controller.profile.value?.jenisKelamin == "Perempuan"
                          ? Icons.person_2
                          : Icons.person,
                      size: 40,
                      color: AppColor.black,
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
                      if (controller.profile.value?.nomorKeanggotaan != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            controller.profile.value!.nomorKeanggotaan!,
                            style: AppTextStyle.ts12CLight.copyWith(
                              color: calculateLuminance(theme.primaryColor)
                                  .withOpacity(0.8),
                            ),
                          ),
                        ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Text(
                              controller.profile.value?.isPending == true
                                  ? "Pending"
                                  : "Aktif",
                              style: AppTextStyle.ts10Bold.copyWith(
                                color:
                                    controller.profile.value?.isPending == true
                                        ? Colors.orange
                                        : Colors.green,
                              ),
                            ),
                          ),
                          if ((controller
                                      .profile.value?.totalBukuFisikDipinjam ??
                                  0) >
                              0)
                            Container(
                              margin: const EdgeInsets.only(top: 4, left: 4),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 8),
                              decoration: BoxDecoration(
                                color: calculateLuminance(theme.primaryColor)
                                    .withOpacity(0.2),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(12)),
                              ),
                              child: Text(
                                "${controller.profile.value!.totalBukuFisikDipinjam} Buku Fisik Dipinjam",
                                style: AppTextStyle.ts10Bold.copyWith(
                                  color: calculateLuminance(theme.primaryColor),
                                ),
                              ),
                            ),
                        ],
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
