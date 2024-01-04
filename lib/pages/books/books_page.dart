import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../api/api_path.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../shared/widget/book_card.dart';
import '../../theme/app_text_stlye.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    const categories = [1, 2, 3, 4, 5, 6, 8, 9, 7];
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
        padding: const EdgeInsets.only(top: Sizes.s, bottom: Sizes.m),
        itemCount: categories.length,
        itemBuilder: (ctx, idx) {
          var category = categories[idx];
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
                        Image.network(APIPath.publicAsset("7f8d2679-9c9c-4bab-8b5f-cab95d64dab7")),
                        HGap.s,
                        Text(
                          "Sains $category",
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
                      BookCard(
                        judul: 'Lorem Ipsum Dolor Sit Amet',
                        penulis: 'The Bagindas',
                        idSampul: '0696f2d7-942f-4e48-94ed-ef10d266263a',
                        harga: '15',
                        copy: '20',
                        isWishlist: true,
                        onTap: () {},
                        onChangeWishlist: () {},
                      ),
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
