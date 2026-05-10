import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

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
import '../../utils/responsive_helper.dart';
import 'controller/category_controller.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CategoryController>();
    final theme = Theme.of(context);
    final crossAxisCount = ResponsiveHelper.getCrossAxisCount(
      context,
      mobile: 2,
      tablet: 3,
      desktop: 4,
    );
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final String categoryName = controller.category.value.nama ?? "-";
          return Text(
            categoryName,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.ts18Bold,
          );
        }),
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
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxContentWidth(context),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.getHorizontalPadding(context),
            ),
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
                  controller: controller.scrollController,
                  padding: const EdgeInsets.only(bottom: Sizes.m),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Obx(() {
                    final String categoryName = controller.category.value.nama ?? "-";
                    final filteredBooks = controller.filteredBooks.value;
                    final _ = controller.asc.value; // Untuk trigger re-render
                    // ignore: unused_local_variable
                    final page = controller.page.value; // Untuk trigger re-render
                    if (filteredBooks == null) {
                      return AlignedGridView.count(
                        shrinkWrap: true,
                        crossAxisCount: crossAxisCount,
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
                            description: "Tidak ada buku di Katalog $categoryName",
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
                      crossAxisCount: crossAxisCount,
                      itemCount: filteredBooks.length,
                      mainAxisSpacing: Sizes.r,
                      crossAxisSpacing: Sizes.r,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final payload = filteredBooks[index];
                        final buku = payload.buku;
                        return BookCard(
                          bukuPerpustakaan: BukuPerpustakaan.fromJson(payload.toJson()),
                          id: buku?.id ?? "-",
                          judul: buku?.judul ?? '-',
                          penulis: buku?.penulis ?? '-',
                          idSampul: buku?.assetSampulId,
                          copy: "${payload.jumlahSiapPinjam ?? '-'}",
                          harga: ((payload.buku?.hargaSewa ?? 0) ~/ 100).toString(),
                          isPromo: buku?.promo != null,
                          onTap: () => Get.toNamed(AppRoutes.book, arguments: payload),
                        );
                      },
                    );
                  }),
                ),
              ),
            ),
            SafeArea(
              child: Obx(() {
                final isLoadedMore = controller.isLoadedMore.value;
                if (isLoadedMore) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: Sizes.s),
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }),
            )
          ],
            ),
          ),
        ),
      ),
    );
  }
}
