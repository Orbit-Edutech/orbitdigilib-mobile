import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_color.dart';
import '../index/controller/index_controller.dart';

class HighlightPage extends StatelessWidget {
  const HighlightPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = Get.find<IndexController>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sorotan"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
        child: ListView(
          children: [
            VGap.m,
            for (var _ in [1, 1, 1, 1]) ...[
              Builder(builder: (context) {
                debugPrint("REBUILD");
                return Container(
                  height: 150,
                  width: size.width,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColor.lightGrey,
                    borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                  ),
                );
              }),
              VGap.r,
            ],
          ],
        ),
      ),
    );
  }
}
