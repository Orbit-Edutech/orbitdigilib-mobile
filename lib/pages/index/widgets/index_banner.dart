import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/material.dart";

import "../../../constants/sizes.dart";
import "../../../theme/app_color.dart";
import "../../../theme/app_text_stlye.dart";
import "../../../utils/compute_luminance.dart";

class IndexBanner extends StatefulWidget {
  const IndexBanner({super.key, required this.banners});

  final List<String> banners;

  @override
  State<IndexBanner> createState() => _IndexBannerState();
}

class _IndexBannerState extends State<IndexBanner> {
  final carouselController = CarouselController();
  int currentBanner = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        CarouselSlider(
          carouselController: carouselController,
          items: widget.banners.map((i) {
            return Container(
              height: 150,
              width: size.width,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColor.lightGrey,
                borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
              ),
              child: Text(
                i,
                style: AppTextStyle.ts20Bold.copyWith(
                  color: calculateLuminance(AppColor.lightGrey),
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            height: 150,
            aspectRatio: 16 / 9,
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
              setState(() {
                currentBanner = idx;
              });
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: Sizes.r,
            horizontal: Sizes.m,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: widget.banners.map((i) {
                  final index = widget.banners.indexOf(i);
                  final current = widget.banners.elementAt(currentBanner) == i;
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
              ),
              GestureDetector(
                onTap: () {},
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
