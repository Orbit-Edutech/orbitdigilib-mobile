import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../shared/widget/book_card.dart';
import '../../theme/app_text_stlye.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    const categories = [1, 1, 1, 1, 1, 1, 1, 1, 1];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Semua Buku"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset("assets/icons/filter.svg"),
          ),
          HGap.r,
        ],
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (ctx, idx) {
          debugPrint((idx).toString());
          if (idx == 0) return VGap.s;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: Sizes.m,
                  right: Sizes.m,
                  top: Sizes.r,
                  bottom: Sizes.s,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset("assets/icons/kategori/sains.png"),
                        Text(
                          "Sains",
                          style: AppTextStyle.ts14Bold,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Lihat Semua",
                        style: AppTextStyle.ts10Light,
                      ),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    HGap.m,
                    for (var _ in [1, 1, 1, 1, 1]) ...[
                      const BookCard(),
                      HGap.r,
                    ],
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
