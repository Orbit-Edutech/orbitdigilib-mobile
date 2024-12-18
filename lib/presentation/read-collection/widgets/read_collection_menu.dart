import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../constants/sizes.dart';
import '../../../shared/widget/app_textfield.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import '../controller/read_collection_controller.dart';

class ReadCollectionMenu extends StatelessWidget {
  const ReadCollectionMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final controller = Get.find<ReadCollectionController>();
    return Container(
      height: size.height / 2,
      width: size.width,
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.l)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.r),
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppTextField(
              type: TextFieldType.rounded,
              controller: controller.searchController,
              focusNode: controller.searchFocusNode,
              onTapOutside: (_) => controller.searchFocusNode.unfocus(),
              isError: false,
              contentPadding: const EdgeInsets.symmetric(vertical: Sizes.s, horizontal: Sizes.r),
              label: Text(
                "Pencarian...",
                style: AppTextStyle.ts18Reg.copyWith(color: AppColor.lightGrey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
