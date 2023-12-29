import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/instance_manager.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../shared/widget/app_textfield.dart';
import '../../shared/widget/book_card.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import 'controller/wishlist_controller.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = Get.find<WishlistController>();
    const books = [1, 2, 3, 4, 5, 1, 2, 3, 4, 5, 1, 2, 3, 4, 5];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            HGap.s,
            Expanded(
              child: Text(
                "Perpustakaan Orbit",
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.ts18Bold,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/filter.svg"),
          ),
          HGap.s,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              VGap.m,
              AppTextField(
                type: TextFieldType.rounded,
                controller: TextEditingController(),
                focusNode: FocusNode(),
                // onTapOutside: (_) => controller.focusNode.unfocus(),
                isError: false,
                contentPadding: const EdgeInsets.symmetric(vertical: Sizes.s, horizontal: Sizes.r),
                label: Text(
                  "Cari judul buku",
                  style: AppTextStyle.ts14Reg.copyWith(color: AppColor.grey),
                ),
              ),
              VGap.r,
              AlignedGridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                itemCount: books.length,
                mainAxisSpacing: Sizes.r,
                crossAxisSpacing: Sizes.r,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return const BookCard();
                },
              ),
              VGap.m,
            ],
          ),
        ),
      ),
    );
  }
}
