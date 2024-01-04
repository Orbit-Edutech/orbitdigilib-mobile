import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../shared/widget/app_textfield.dart';
import '../../shared/widget/book_card_horz.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import 'controller/search_page_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SearchPageController>();
    const listBuku = [1, 1, 1, 1, 1, 1, 1, 1, 1];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Pencarian"),
        actions: [
          IconButton(
            onPressed: controller.showFilterModal,
            icon: SvgPicture.asset(
              "assets/icons/filter.svg",
            ),
          ),
          HGap.s,
        ],
      ),
      body: Column(
        children: [
          VGap.m,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
            child: AppTextField(
              type: TextFieldType.rounded,
              controller: controller.textController,
              focusNode: controller.searchFocusNode,
              onTapOutside: (_) => controller.searchFocusNode.unfocus(),
              isError: false,
              contentPadding: const EdgeInsets.symmetric(vertical: Sizes.s, horizontal: Sizes.r),
              label: Text(
                "Pencarian...",
                style: AppTextStyle.ts18Reg.copyWith(color: AppColor.lightGrey),
              ),
            ),
          ),
          VGap.s,
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (ctx, idx) {
                if (idx == 0 || idx == listBuku.length) return VGap.r;
                return const Column(
                  children: [
                    BookCardHorz(),
                    VGap.s,
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
