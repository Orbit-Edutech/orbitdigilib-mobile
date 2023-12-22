import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

import '../../constants/sizes.dart';
import '../../shared/widget/app_button.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/compute_luminance.dart';
import '../../constants/gaps.dart';
import 'controller/index_controller.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final controller = Get.find<IndexController>();
  bool loaded = false;
  bool isRead = true;
  bool isVisible = true;
  List<String> banners = ["Satu", "Dua", "Tiga", "Empat"];
  final carouselController = CarouselController();
  int currentBanner = 0;

  List<String> rawCategories = [
    "agama",
    "anak",
    "budaya",
    "fiksi",
    "hankam",
    "hobby",
    "hukum",
    "humaniora",
    "kamus",
    "keluarga",
    "kesehatan",
    "ketrampilan-khusus",
    "komik",
    "lifestyle",
    "medis",
    "pendidikan",
    "politik",
    "psikologi",
    "sains",
    "sastra",
    "sejarah",
    "seni-design",
    "sosial",
    "teknik"
  ];
  List<String> categories = [];
  @override
  void initState() {
    // Method ini untuk trigger update App Theme (default biru)
    if (mounted) {
      if (rawCategories.length > 7) {
        categories = rawCategories.take(7).toList();
      } else {
        categories = rawCategories;
      }
      Future.delayed(const Duration(seconds: 1)).then((value) {
        setState(() {
          loaded = true;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    if (loaded == false) return const Scaffold();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            HGap.s,
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/icons/icon.png",
                  width: 35,
                  height: 35,
                  color: Colors.brown.shade300,
                ),
              ],
            ),
            HGap.r,
            Expanded(
              child: Text(
                "Perpustakaan Orbit",
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.ts18Bold.copyWith(
                  color: calculateLuminance(theme.primaryColor),
                ),
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.search_rounded,
              color: calculateLuminance(theme.primaryColor),
              size: 24,
            ),
          ),
          HGap.r,
          GestureDetector(
            onTap: () => setState(() => isRead = !isRead),
            child: isRead
                ? Icon(
                    Icons.notifications_outlined,
                    color: calculateLuminance(theme.primaryColor),
                    size: 24,
                  )
                : Image.asset(
                    "assets/icons/notifications-unread.png",
                    height: 20,
                    width: 24,
                  ),
          ),
          HGap.m,
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: Sizes.m),
        child: Column(
          children: [
            CarouselSlider(
              carouselController: carouselController,
              items: banners.map((i) {
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
                    children: banners.map((i) {
                      final index = banners.indexOf(i);
                      final current = banners.elementAt(currentBanner) == i;
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
            VGap.s,
            Container(
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
                      color: AppColor.lightGrey,
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
                          Image.asset(
                            "assets/icons/database.png",
                            width: 24,
                            height: 24,
                            filterQuality: FilterQuality.high,
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
                    onTap: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add_circle_rounded,
                          color: theme.primaryColor,
                        ),
                        HGap.xs,
                        Text(
                          "Isi Saldo",
                          style: AppTextStyle.ts12Bold,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.s),
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VGap.r,
                  Text(
                    "Kategori Buku",
                    style: AppTextStyle.ts14Bold,
                  ),
                  VGap.r,
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    crossAxisCount: 4,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: Sizes.xs,
                    children: [
                      for (String category in categories) ...[
                        Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset(
                                  "assets/icons/kategory-bg.png",
                                  width: 56,
                                  height: 56,
                                  color: theme.colorScheme.primaryContainer.withOpacity(.25),
                                ),
                                Image.asset(
                                  "assets/icons/kategori/$category.png",
                                  width: 24,
                                  height: 24,
                                  color: theme.primaryColor,
                                ),
                              ],
                            ),
                            VGap.xs,
                            Text(
                              category,
                              style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        )
                      ],
                      if (rawCategories.length > 7)
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              SizedBox(
                                height: Get.size.height * 0.6,
                                width: Get.size.width,
                                child: Container(
                                  alignment: Alignment.topCenter,
                                  padding: const EdgeInsets.all(Sizes.m),
                                  width: size.width,
                                  height: size.height,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(Sizes.l),
                                      topRight: Radius.circular(Sizes.l),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        "Kategori Buku",
                                        style: AppTextStyle.ts14Bold,
                                        textAlign: TextAlign.start,
                                      ),
                                      VGap.r,
                                      Expanded(
                                        child: GridView.count(
                                          shrinkWrap: false,
                                          padding: EdgeInsets.zero,
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 0,
                                          mainAxisSpacing: Sizes.xs,
                                          children: rawCategories.map((cat) {
                                            return Column(
                                              children: [
                                                Stack(
                                                  alignment: Alignment.center,
                                                  children: [
                                                    Image.asset(
                                                      "assets/icons/kategory-bg.png",
                                                      width: 56,
                                                      height: 56,
                                                      color: theme.colorScheme.primaryContainer.withOpacity(.25),
                                                    ),
                                                    Image.asset(
                                                      "assets/icons/kategori/$cat.png",
                                                      width: 24,
                                                      height: 24,
                                                      color: theme.primaryColor,
                                                    ),
                                                  ],
                                                ),
                                                VGap.xs,
                                                Text(
                                                  cat,
                                                  style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                                                  overflow: TextOverflow.ellipsis,
                                                )
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      VGap.r,
                                      AppButton(
                                        type: ButtonType.outlined,
                                        onPressed: Get.back,
                                        child: Text("Tutup", style: AppTextStyle.ts14Bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.r)),
                              ),
                              isScrollControlled: true,
                              enableDrag: false,
                            );
                          },
                          child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    "assets/icons/kategory-bg.png",
                                    width: 56,
                                    height: 56,
                                    color: theme.primaryColor,
                                  ),
                                  Image.asset(
                                    "assets/icons/kategori/semua.png",
                                    width: 24,
                                    height: 24,
                                    color: AppColor.white,
                                  ),
                                ],
                              ),
                              VGap.xs,
                              Text(
                                "Semua",
                                style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                              )
                            ],
                          ),
                        )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.s),
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VGap.r,
                  Text(
                    "Rekomendasi Buku",
                    style: AppTextStyle.ts14Bold,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
