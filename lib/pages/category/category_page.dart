import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../api/kategori-perpus/model/model_kategori_perpus_all.dart' as k;
import '../../api/wishlist/model/model_wishlist_all.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../routes/app_routes.dart';
import '../../shared/widget/app_textfield.dart';
import '../../shared/widget/book_card.dart';
import '../../shared/widget/book_card_skeleton.dart';
import '../../shared/widget/empty_list.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/compute_luminance.dart';
import 'controller/category_controller.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryController>();
    final k.KategoriBukuPerpustakaan category = Get.arguments;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.nama ?? "-",
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.ts18Bold,
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
                "Pencarian...",
                style: AppTextStyle.ts18Reg.copyWith(color: AppColor.grey),
              ),
            ),
            VGap.r,
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => await controller.onInit(),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: Sizes.m),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Obx(() {
                    final filteredBooks = controller.filteredBooks.value;
                    final _ = controller.asc.value; // Untuk trigger re-render
                    if (filteredBooks == null) {
                      return AlignedGridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        itemCount: 10,
                        mainAxisSpacing: Sizes.r,
                        crossAxisSpacing: Sizes.r,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return const BookCardSkeleton();
                        },
                      );
                    }
                    if (controller.books.value?.isEmpty ?? true) {
                      return Column(
                        children: [
                          VGap.m,
                          EmptyList(
                            description: "Tidak ada buku di Kategori ${category.nama}",
                          ),
                        ],
                      );
                    }
                    if (filteredBooks.isEmpty) {
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
                      itemCount: 10,
                      mainAxisSpacing: Sizes.r,
                      crossAxisSpacing: Sizes.r,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        // final buku = filteredBooks[index].buku;
                        return BookCard(
                          bukuPerpustakaan: BukuPerpustakaan(),
                          id: "",
                          judul: "Lorem Ipsum Dolor Sit Amet",
                          penulis: "Aku Ready",
                          idSampul: '0696f2d7-942f-4e48-94ed-ef10d266263a',
                          harga: '1',
                          copy: '2',
                          onTap: () => Get.toNamed(AppRoutes.book, arguments: "payload"),
                          onChangeWishlist: () {},
                        );
                      },
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
