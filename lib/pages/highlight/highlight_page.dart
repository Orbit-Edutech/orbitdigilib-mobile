import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../api/api_path.dart';
import '../../api/perpustakaan/model/model_perpustakaan.dart' as p;
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../index/controller/index_controller.dart';

class HighlightPage extends StatelessWidget {
  const HighlightPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<IndexController>();
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
            for (p.Banner banner in controller.perpustakaan.value?.banner ?? []) ...[
              Builder(builder: (context) {
                debugPrint("REBUILD");
                return Container(
                  height: 150,
                  width: size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(APIPath.publicAsset(banner.id ?? "")),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
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
