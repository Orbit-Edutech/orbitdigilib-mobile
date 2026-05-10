import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
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
import 'controller/books_controller.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BooksController>();
    final crossAxisCount = ResponsiveHelper.getCrossAxisCount(
      context,
      mobile: 2,
      tablet: 3,
      desktop: 4,
    );
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final category = controller.category.value?.nama ?? "";
          return Text("Semua Buku $category");
        }),
        actions: [
          IconButton(
            onPressed: controller.onSearch,
            icon: Icon(
              Icons.search,
              color: calculateLuminance(theme.primaryColor),
            ),
          ),
          Obx(() {
            final categories = controller.categories.value;
            if (categories == null) return const SizedBox();
            return IconButton(
              onPressed: controller.showFilter,
              icon: SvgPicture.asset("assets/icons/filter.svg"),
            );
          }),
          IconButton(
            onPressed: controller.sortBooks,
            icon: Icon(
              Icons.swap_vert_rounded,
              color: calculateLuminance(theme.primaryColor),
            ),
          ),
          HGap.sr,
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveHelper.getMaxContentWidth(context),
            ),
            child: Column(
              children: [
                Obx(() {
                  return Column(
                    children: [
                      if (controller.isOnSearch.value) ...[
                        VGap.r,
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.getHorizontalPadding(context),
                          ),
                          child: AppTextField(
                        type: TextFieldType.rounded,
                        controller: controller.textController,
                        focusNode: controller.searchFocusNode,
                        onTapOutside: (_) => controller.searchFocusNode.unfocus(),
                        onChanged: controller.search,
                        isError: false,
                        autoFocus: true,
                        suffix: IconButton(
                          onPressed: () {
                            if (controller.textController.text.isNotEmpty) controller.search("");
                            controller.textController.clear();
                          },
                          icon: const Icon(Icons.close_rounded),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: Sizes.s, horizontal: Sizes.r),
                        label: Text(
                          "Pencarian...",
                          style: AppTextStyle.ts18Reg.copyWith(color: AppColor.lightGrey),
                        ),
                      ),
                    ),
                    VGap.s,
                  ],
                ],
              );
            }),
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.onInit,
                child: GetBuilder<BooksController>(builder: (_) {
                  final books = controller.books.value;
                  final _ = controller.isLoadedMore.value;
                  if (books == null) {
                    return AlignedGridView.count(
                      shrinkWrap: true,
                      crossAxisCount: crossAxisCount,
                      itemCount: 10,
                      mainAxisSpacing: Sizes.r,
                      crossAxisSpacing: Sizes.r,
                      padding: EdgeInsets.all(ResponsiveHelper.getHorizontalPadding(context)),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const BookCardSkeleton();
                      },
                    );
                  } else if (books.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.all(ResponsiveHelper.getHorizontalPadding(context)),
                      child: const EmptyList(description: "Buku yang Anda cari tidak ada"),
                    );
                  }
                  return AlignedGridView.count(
                    controller: controller.scrollController,
                    shrinkWrap: true,
                    crossAxisCount: crossAxisCount,
                    itemCount: books.length,
                    mainAxisSpacing: Sizes.r,
                    crossAxisSpacing: Sizes.r,
                    padding: EdgeInsets.all(ResponsiveHelper.getHorizontalPadding(context)),
                    itemBuilder: (context, index) {
                      final payload = books[index];
                      final book = payload.buku;
                      return BookCard(
                        bukuPerpustakaan: BukuPerpustakaan.fromJson(payload.toJson()),
                        id: book?.id ?? "-",
                        judul: book?.judul ?? "-",
                        penulis: book?.penulis ?? "-",
                        idSampul: book?.assetSampulId,
                        copy: "${payload.jumlahSiapPinjam ?? '-'}",
                        harga: ((payload.buku?.hargaSewa ?? 0) ~/ 100).toString(),
                        isPromo: payload.buku?.promo != null,
                        onTap: () => Get.toNamed(AppRoutes.book, arguments: payload),
                      );
                    },
                  );
                }),
              ),
            ),
            Obx(() {
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
            })
          ],
        ),
          ),
        ),
      ),
    );
  }
}
