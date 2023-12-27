import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:get/route_manager.dart";

import "../../../constants/gaps.dart";
import "../../../constants/sizes.dart";
import "../../../routes/app_routes.dart";
import "../../../theme/app_color.dart";
import "../../../theme/app_text_stlye.dart";

class IndexBalance extends StatefulWidget {
  const IndexBalance({super.key});

  @override
  State<IndexBalance> createState() => _IndexBalanceState();
}

class _IndexBalanceState extends State<IndexBalance> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
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
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage("assets/icons/icon.png")),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
          ),
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    "assets/icons/coin.svg",
                    width: 24,
                    height: 24,
                    colorFilter: const ColorFilter.mode(AppColor.black, BlendMode.srcIn),
                  ),
                  HGap.xs,
                  Text(
                    isVisible ? "2800" : "• • • •",
                    style: AppTextStyle.ts20Bold,
                  ),
                  HGap.xs,
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: isVisible
                        ? const Icon(
                            Icons.visibility_rounded,
                            size: 16,
                            color: AppColor.black,
                          )
                        : const Icon(
                            Icons.visibility_off_rounded,
                            size: 16,
                            color: AppColor.black,
                          ),
                  )
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
