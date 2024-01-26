import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../api/buku-perpustakaan/model/model_all_buku_perpustakaan.dart';
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
import 'controller/wishlist_controller.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WishlistController>();
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isWide = size.width >= 600;
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
                  child: GetBuilder<WishlistController>(
                    init: controller,
                    builder: (WishlistController c) {
                      final filteredWishlist = c.filteredWishlist.value;
                      final _ = c.asc.value; // Untuk trigger re-render
                      if (filteredWishlist == null) {
                        return AlignedGridView.count(
                          shrinkWrap: true,
                          crossAxisCount: isWide ? 4 : 2,
                          itemCount: 10,
                          mainAxisSpacing: Sizes.r,
                          crossAxisSpacing: Sizes.r,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return const BookCardSkeleton();
                          },
                        );
                      }
                      if (c.wishlist.value?.isEmpty ?? true) {
                        return const Column(
                          children: [
                            VGap.m,
                            EmptyList(
                              description: "Anda belum mempunyai wishlist buku",
                            ),
                          ],
                        );
                      }
                      if (filteredWishlist.isEmpty) {
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
                        crossAxisCount: isWide ? 4 : 2,
                        itemCount: filteredWishlist.length,
                        mainAxisSpacing: Sizes.r,
                        crossAxisSpacing: Sizes.r,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final payload = filteredWishlist[index].bukuPerpustakaan;
                          final buku = payload?.buku;
                          return BookCard(
                            bukuPerpustakaan: payload!,
                            id: buku?.id ?? "-",
                            judul: buku?.judul ?? "-",
                            penulis: buku?.penulis ?? "-",
                            idSampul: buku?.assetSampulId ?? "-",
                            copy: "${payload.jumlahSiapPinjam ?? '-'}",
                            harga: (int.parse(buku?.hargaSewa ?? "0") ~/ 100).toString(),
                            onTap: () => Get.toNamed(AppRoutes.book, arguments: Payload.fromJson(payload.toJson())),
                            onChangeWishlist: () {},
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
