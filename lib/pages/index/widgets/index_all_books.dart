import "package:flutter/material.dart";
import "package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart";
import "package:get/route_manager.dart";

import "../../../constants/gaps.dart";
import "../../../constants/sizes.dart";
import "../../../routes/app_routes.dart";
import "../../../shared/widget/app_button.dart";
import "../../../shared/widget/book_card.dart";
import "../../../theme/app_text_stlye.dart";

class IndexAllBooks extends StatelessWidget {
  const IndexAllBooks({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          VGap.m,
          Text(
            "Semua Buku",
            style: AppTextStyle.ts14Bold,
          ),
          VGap.r,
          AlignedGridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            itemCount: 10,
            mainAxisSpacing: Sizes.r,
            crossAxisSpacing: Sizes.r,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return BookCard(
                judul: 'Lorem Ipsum Dolor Sit Amet Lorem Ipsum Dolor',
                penulis: "Tere Liye",
                idSampul: '0696f2d7-942f-4e48-94ed-ef10d266263a',
                copy: '1',
                harga: "20",
                isWishlist: true,
                onTap: () {},
                onChangeWishlist: () {},
              );
            },
          ),
          VGap.r,
          AppButton(
            type: ButtonType.elevated,
            backgroundColor: theme.primaryColor,
            onPressed: () => Get.toNamed(AppRoutes.books),
            child: const Text("Lihat Semua"),
          ),
        ],
      ),
    );
  }
}
