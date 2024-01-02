import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../shared/widget/app_textfield.dart';
import '../../shared/widget/book_card.dart';
import '../../shared/widget/empty_list.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/compute_luminance.dart';
import 'controller/wishlist_controller.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WishlistController>();
    final theme = Theme.of(context);
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
            onPressed: controller.sort,
            icon: Icon(
              Icons.swap_vert_rounded,
              color: calculateLuminance(theme.primaryColor),
            ),
          ),
          HGap.s,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
        child: Column(
          children: [
            VGap.m,
            AppTextField(
              type: TextFieldType.rounded,
              controller: controller.textController,
              focusNode: controller.focusNode,
              onTapOutside: (_) => controller.focusNode.unfocus(),
              onChanged: controller.onSearch,
              isError: false,
              contentPadding: const EdgeInsets.symmetric(vertical: Sizes.s, horizontal: Sizes.r),
              suffix: GestureDetector(
                onTap: () {
                  controller.onSearch("");
                  controller.textController.clear();
                },
                child: const Icon(Icons.close_rounded),
              ),
              label: Text(
                "Cari judul buku",
                style: AppTextStyle.ts14Reg.copyWith(color: AppColor.grey),
              ),
            ),
            VGap.r,
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: Sizes.m),
                child: Obx(() {
                  final books = controller.filteredBooks.value;
                  final _ = controller.asc.value; // Untuk trigger re-render
                  if (controller.books.isEmpty) {
                    return const Column(
                      children: [
                        VGap.m,
                        EmptyList(
                          description: "Aamu belum mempunyai wishlist buku",
                        ),
                      ],
                    );
                  }
                  if (books?.isEmpty ?? true) {
                    return const Column(
                      children: [
                        VGap.m,
                        EmptyList(
                          description: "Buku yang Anda cari tidak ada",
                        ),
                      ],
                    );
                  }
                  return AlignedGridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    itemCount: books?.length,
                    mainAxisSpacing: Sizes.r,
                    crossAxisSpacing: Sizes.r,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final book = books?[index];
                      return BookCard(
                        judul: book ?? "-",
                        penulis: 'TERE LIYE',
                        idSampul: '0696f2d7-942f-4e48-94ed-ef10d266263a',
                        harga: '20',
                        copy: '10',
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
