import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import 'controller/faq_controller.dart';
import 'widgets/faq_card.dart';

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FAQController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pusat Bantuan"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: Sizes.m),
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/icons/icon.png"),
                ),
              ),
            ),
            Text("ORBIT DIGILIB", style: AppTextStyle.ts24Bold),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dikembangkan oleh ", style: AppTextStyle.ts12Reg),
                Text(
                  "Orbit360",
                  style: AppTextStyle.ts12Bold.copyWith(color: AppColor.orange),
                ),
              ],
            ),
            VGap.m,
            Obx(() {
              final listFAQ = controller.listFAQ.value;
              if (listFAQ == null) {
                return Column(
                  children: List.generate(10, (index) => index).map((e) {
                    return Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.s),
                      decoration: const BoxDecoration(
                        color: AppColor.lightGrey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(Sizes.xs),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }
              return ListView.builder(
                itemCount: listFAQ.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final faq = listFAQ[index];
                  return FAQCard(faq: faq);
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
