import "package:cached_network_image/cached_network_image.dart";
import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart";
import "package:get/instance_manager.dart";
import "package:get/route_manager.dart";

import '../../../api/api_path.dart';
import '../../../constants/sizes.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import "../controller/index_controller.dart";

class IndexBanner extends StatefulWidget {
  const IndexBanner({super.key});

  @override
  State<IndexBanner> createState() => _IndexBannerState();
}

class _IndexBannerState extends State<IndexBanner> {
  final controller = Get.find<IndexController>();
  final carouselController = CarouselController();
  int currentBanner = 0;
  List<String> emptyBanners = ["", "", "", ""];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Obx(() {
          final banners = controller.banners.value;
          final isEmpty = banners.isEmpty;
          return CarouselSlider(
            carouselController: carouselController,
            items: (isEmpty ? emptyBanners : banners).map((banner) {
              return InkWell(
                onTap: () => controller.showLargeBanner(banners, banners.indexOf(banner)),
                borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
                child: Container(
                  height: 150,
                  width: size.width,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(
                    color: AppColor.lightGrey,
                    borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                  ),
                  child: isEmpty
                      ? const SizedBox()
                      : CachedNetworkImage(imageUrl: APIPath.publicAsset(banner), fit: BoxFit.cover),
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: 150,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 8),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.25,
              onPageChanged: (idx, reaseon) {
                setState(() => currentBanner = idx);
              },
              scrollDirection: Axis.horizontal,
            ),
          );
        }),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.r,
            horizontal: Sizes.m,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                final banners = controller.banners.value;
                final isEmpty = banners.isEmpty;
                return Row(
                  children: (isEmpty ? emptyBanners : banners).map((i) {
                    final index = (isEmpty ? emptyBanners : banners).indexOf(i);
                    final current = (isEmpty ? emptyBanners : banners).elementAt(currentBanner) == i;
                    return GestureDetector(
                      onTap: () => carouselController.animateToPage(index),
                      child: Container(
                        width: Sizes.s,
                        height: Sizes.s,
                        decoration: BoxDecoration(
                          color: current ? theme.primaryColor : AppColor.lightGrey,
                          shape: BoxShape.circle,
                        ),
                        margin: const EdgeInsets.only(right: Sizes.xs),
                      ),
                    );
                  }).toList(),
                );
              }),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.highlight),
                child: Text(
                  "Lihat Semua",
                  style: AppTextStyle.ts12Reg.copyWith(color: theme.primaryColor),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
