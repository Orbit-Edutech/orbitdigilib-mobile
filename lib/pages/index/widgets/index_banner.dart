import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";
import "package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart";
import "package:get/instance_manager.dart";
import "package:get/route_manager.dart";

import "../../../api/api_path.dart";
import "../../../api/perpustakaan/model/model_perpustakaan.dart" as p;
import "../../../constants/sizes.dart";
import "../../../routes/app_routes.dart";
import "../../../theme/app_color.dart";
import "../../../theme/app_text_stlye.dart";
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
  List<p.Banner> emptyBanners = [p.Banner(), p.Banner(), p.Banner(), p.Banner()];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Obx(() {
          final banners = controller.perpustakaan.value?.banner;
          final isEmpty = banners == null;
          return CarouselSlider(
            carouselController: carouselController,
            items: (isEmpty ? emptyBanners : banners).map((banner) {
              return Container(
                height: 150,
                width: size.width,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: const BoxDecoration(
                  color: AppColor.lightGrey,
                  borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                ),
                child: isEmpty
                    ? const SizedBox()
                    : Image.network(
                        APIPath.publicAsset(banner.id!),
                        fit: BoxFit.cover,
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
                final banners = controller.perpustakaan.value?.banner;
                final isEmpty = banners?.isEmpty ?? true;
                return Row(
                  children: (isEmpty ? emptyBanners : banners)!.map((i) {
                    final index = (isEmpty ? emptyBanners : banners)!.indexOf(i);
                    final current = (isEmpty ? emptyBanners : banners)!.elementAt(currentBanner) == i;
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
