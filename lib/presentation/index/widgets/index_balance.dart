import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart";
import "package:get/instance_manager.dart";
import "package:get/route_manager.dart";

import '../../../api/api_path.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import "../../profile/controller/profile_controller.dart";
import "../controller/index_controller.dart";

class IndexBalance extends StatelessWidget {
  const IndexBalance({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<IndexController>();
    final profileController = Get.find<ProfileController>();
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.s),
      padding: const EdgeInsets.symmetric(horizontal: Sizes.r, vertical: Sizes.s),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.primaryColor,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Obx(() {
                final idLogo = controller.perpustakaan.value?.assetLogo?.id ?? "";
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(APIPath.publicAsset(idLogo)),
                      fit: BoxFit.cover,
                    ),
                  ),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                );
              }),
              HGap.m,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: Sizes.xs),
                    child: Text(
                      "Token DIGILIB Anda",
                      style: AppTextStyle.ts12Reg,
                    ),
                  ),
                  Obx(() {
                    final isVisible = controller.isBalanceVisible.value;
                    final balance = profileController.profile.value?.token?.split(".")[0] ?? "0";
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/coin.svg",
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(AppColor.black, BlendMode.srcIn),
                        ),
                        HGap.xs,
                        Flexible(
                          child: Text(
                            isVisible ? balance : "• • • •",
                            style: AppTextStyle.ts20Bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        HGap.xs,
                        GestureDetector(
                          onTap: () => controller.isBalanceVisible.value = !controller.isBalanceVisible.value,
                          child: Icon(
                            isVisible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                            size: 16,
                            color: AppColor.black,
                          ),
                        )
                      ],
                    );
                  }),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.token),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add_circle_rounded,
                  color: theme.primaryColor,
                ),
                HGap.xs,
                Text(
                  "Isi Token",
                  style: AppTextStyle.ts12Bold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
