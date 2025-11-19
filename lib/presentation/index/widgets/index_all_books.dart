import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart";
import "package:get/instance_manager.dart";
import "package:get/route_manager.dart";

import '../../../api/wishlist/model/model_wishlist_all.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/book_card.dart';
import '../../../shared/widget/book_card_skeleton.dart';
import '../../../shared/widget/empty_list.dart';
import '../../../theme/app_text_stlye.dart';
import '../../../utils/responsive_helper.dart';
import "../controller/index_controller.dart";

class IndexAllBooks extends StatelessWidget {
  const IndexAllBooks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = ResponsiveHelper.getCrossAxisCount(
      context,
      mobile: 2,
      tablet: 3,
      desktop: 4,
    );
    final theme = Theme.of(context);
    final controller = Get.find<IndexController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        VGap.m,
        Text(
          "Semua Buku",
          style: AppTextStyle.ts14Bold,
        ),
        VGap.r,
        Obx(() {
          final books = controller.allBooks.value;
          if (books == null) {
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
          } else if (books.isEmpty) {
            return const EmptyList(description: "Buku perpustakaan masih kosong");
          }
          return AlignedGridView.count(
            shrinkWrap: true,
            crossAxisCount: crossAxisCount,
            itemCount: books.length,
            mainAxisSpacing: Sizes.r,
            crossAxisSpacing: Sizes.r,
            physics: const NeverScrollableScrollPhysics(),
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
        VGap.r,
        Obx(() {
          final isBooksEmpty = (controller.allBooks.value ?? []).isEmpty;
          if (isBooksEmpty) return const SizedBox();
          return AppButton(
            type: ButtonType.elevated,
            backgroundColor: theme.primaryColor,
            onPressed: () => Get.toNamed(AppRoutes.books),
            child: const Text("Lihat Semua"),
          );
        })
      ],
    );
  }
}
