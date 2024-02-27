import 'package:flutter/material.dart';

import '../../../api/buku-perpustakaan/model/model_one_buku_perpustakaan.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../theme/app_color.dart';
import 'book_about.dart';
import 'book_buttons.dart';
import 'book_detail.dart';

class BookMetadata extends StatelessWidget {
  const BookMetadata({
    super.key,
    required this.book,
  });

  final Buku? book;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      constraints: BoxConstraints(minHeight: size.height - 150),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.l)),
        color: AppColor.white,
      ),
      padding: const EdgeInsets.all(Sizes.m),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          VGap.h,
          VGap.h,
          VGap.s,
          BookDetail(book: book),
          VGap.r,
          BookAbout(book: book),
          VGap.m,
          BookButtons(book: book),
        ],
      ),
    );
  }
}
