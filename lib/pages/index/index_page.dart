import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';

import '../../constants/sizes.dart';
import '../../constants/gaps.dart';
import '../../theme/app_color.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final perpustakaan = controller.perpustakaan.value;
      return Container(
        color: AppColor.bgScaffold,
        child: AnimatedOpacity(
          opacity: perpustakaan == null ? 0 : 1,
          duration: const Duration(seconds: 1),
          child: const Scaffold(
            appBar: IndexAppBar(),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: Sizes.m),
              child: Column(
                children: [
                  IndexBanner(),
                  VGap.s,
                  IndexBalance(),
                  IndexCategories(),
                  IndexRecommendation(),
                  IndexAllBooks(),
                  VGap.r,
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
