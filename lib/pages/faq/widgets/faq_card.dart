import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../../api/faq/model/model_faq.dart';
import '../../../constants/sizes.dart';
import '../../../theme/app_text_stlye.dart';
import '../controller/faq_controller.dart';

class FAQCard extends StatelessWidget {
  const FAQCard({
    super.key,
    required this.faq,
  });

  final FAQ faq;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FAQController>();
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Obx(() {
      final isAnswerVisible = controller.currentFAQ.value == faq;
      return InkWell(
        onTap: () => controller.setCurrentFAQ = faq,
        child: Container(
          width: size.width,
          color: isAnswerVisible ? theme.colorScheme.primaryContainer.withOpacity(.25) : Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.s),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    faq.pertanyaan ?? "-",
                    style: AppTextStyle.ts10Bold.copyWith(color: theme.primaryColor),
                    textAlign: TextAlign.justify,
                  ),
                  Icon(
                    isAnswerVisible ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                    color: theme.primaryColor,
                  )
                ],
              ),
              Visibility(
                visible: isAnswerVisible,
                child: Text(
                  faq.jawaban ?? "-",
                  style: AppTextStyle.ts10Light,
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
