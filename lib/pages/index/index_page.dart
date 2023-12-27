import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

import '../../constants/sizes.dart';
import '../../constants/gaps.dart';
import 'controller/index_controller.dart';
import 'widgets/index_all_books.dart';
import 'widgets/index_app_bar.dart';
import 'widgets/index_balance.dart';
import 'widgets/index_banner.dart';
import 'widgets/index_categories.dart';
import 'widgets/index_recommendation.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  // TODO: Buat controller untuk Index Page
  final controller = Get.find<IndexController>();
  bool loaded = false;
  bool isRead = true;
  bool isVisible = true;
  List<String> banners = ["Satu", "Dua", "Tiga", "Empat"];

  List<String> categories = [
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
  @override
  void initState() {
    // Method ini untuk trigger update App Theme (default biru)
    if (mounted) {
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
    if (loaded == false) return const Scaffold();
    return Scaffold(
      appBar: const IndexAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: Sizes.m),
        child: Column(
          children: [
            IndexBanner(banners: banners),
            VGap.s,
            const IndexBalance(),
            IndexCategories(categories: categories),
            const IndexRecommendation(),
            const IndexAllBooks(),
            VGap.r,
          ],
        ),
      ),
    );
  }
}
