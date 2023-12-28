import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../shared/widget/app_textfield.dart';
import '../../shared/widget/book_card_horz.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import 'controller/search_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SearchPageController>();
    const listBuku = [1, 1, 1, 1, 1, 1, 1, 1, 1];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pencarian"),
        actions: [
          // list filter: judul, asc-dsc, harga sewa, jumlah stok, nama penulis
          IconButton(
            onPressed: controller.showFilterModal,
            icon: SvgPicture.asset(
              "assets/icons/filter.svg",
            ),
          )
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
              focusNode: controller.focusNode,
              onTapOutside: (_) => controller.focusNode.unfocus(),
              isError: false,
              contentPadding: const EdgeInsets.symmetric(vertical: Sizes.s, horizontal: Sizes.r),
              label: Text(
                "Cari judul buku",
                style: AppTextStyle.ts14Reg.copyWith(color: AppColor.grey),
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
