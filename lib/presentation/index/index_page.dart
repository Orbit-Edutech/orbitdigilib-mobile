import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../constants/sizes.dart';
import '../../constants/gaps.dart';
import '../../utils/responsive_helper.dart';
import '../profile/controller/profile_controller.dart';
import 'controller/index_controller.dart';
import 'widgets/index_all_books.dart';
import 'widgets/index_app_bar.dart';
import 'widgets/index_balance.dart';
import 'widgets/index_banner.dart';
import 'widgets/index_categories.dart';
import 'widgets/index_recommendation.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<IndexController>();
    final profileController = Get.find<ProfileController>();
    return Obx(() {
      final perpustakaan = controller.perpustakaan.value;
      return AnimatedOpacity(
        opacity: perpustakaan == null ? 0 : 1,
        duration: const Duration(milliseconds: 100),
        child: Scaffold(
          appBar: const IndexAppBar(),
          body: RefreshIndicator(
            onRefresh: () async {
              await controller.onInit();
              await profileController.onInit();
            },
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: ResponsiveHelper.getMaxContentWidth(context),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    vertical: Sizes.m,
                    horizontal: ResponsiveHelper.getHorizontalPadding(context),
                  ),
                  child: Column(
                    children: perpustakaan != null
                        ? [
                            const IndexBanner(),
                            VGap.s,
                            const IndexBalance(),
                            const IndexCategories(),
                            const IndexRecommendation(),
                            const IndexAllBooks(),
                            VGap.r,
                          ]
                        : [],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
