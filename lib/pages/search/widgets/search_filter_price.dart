import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/app_textfield.dart';
import '../../../theme/app_text_stlye.dart';
import '../controller/search_page_controller.dart';

class SearchFilterPrice extends StatelessWidget {
  const SearchFilterPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SearchPageController>();
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Harga", style: AppTextStyle.ts14Bold),
              GestureDetector(
                onTap: controller.clearPrice,
                child: Text("Hapus", style: AppTextStyle.ts12Reg.copyWith(color: theme.primaryColor)),
              )
            ],
          ),
        ),
        VGap.s,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
          child: Row(
            children: [
              Expanded(
                child: AppTextField(
                  type: TextFieldType.rounded,
                  controller: controller.lowerPriceTextController,
                  contentPadding: const EdgeInsets.symmetric(horizontal: Sizes.r, vertical: Sizes.xs),
                  focusNode: controller.lowerPriceFocusNode,
                  isError: false,
                  label: Text("Terendah", style: AppTextStyle.ts14Reg),
                  keyboardType: TextInputType.number,
                ),
              ),
              HGap.s,
              Expanded(
                child: AppTextField(
                  type: TextFieldType.rounded,
                  controller: controller.higherPriceTextController,
                  contentPadding: const EdgeInsets.symmetric(horizontal: Sizes.r, vertical: Sizes.xs),
                  focusNode: controller.higherPriceFocusNode,
                  isError: false,
                  label: Text("Tertinggi", style: AppTextStyle.ts14Reg),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
