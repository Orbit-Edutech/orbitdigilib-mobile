import "package:flutter/material.dart";

import "../../../constants/gaps.dart";
import "../../../constants/sizes.dart";
import "../../../shared/widget/book_card.dart";
import "../../../theme/app_text_stlye.dart";

class IndexRecommendation extends StatelessWidget {
  const IndexRecommendation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VGap.m,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
          child: Text(
            "Rekomendasi Buku",
            style: AppTextStyle.ts14Bold,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(vertical: Sizes.m),
          child: Row(
            children: [
              HGap.m,
              for (var _ in [1, 2, 3, 4, 1, 1, 1, 1, 1, 1]) ...[const BookCard(), HGap.r],
              HGap.m,
            ],
          ),
        ),
      ],
    );
  }
}
