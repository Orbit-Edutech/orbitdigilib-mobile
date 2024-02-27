import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../api/buku-perpustakaan/model/model_one_buku_perpustakaan.dart';
import '../../../constants/gaps.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class BookDetail extends StatelessWidget {
  const BookDetail({
    super.key,
    required this.book,
  });

  final Buku? book;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          book?.judul ?? "-",
          style: AppTextStyle.ts18Bold,
          textAlign: TextAlign.center,
        ),
        Text(
          book?.penulis ?? "-",
          style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
          textAlign: TextAlign.center,
        ),
        VGap.s,
        ReadMoreText(
          book?.sinopsis ?? "-",
          style: AppTextStyle.ts12Light,
          textAlign: TextAlign.justify,
          trimCollapsedText: " Lihat Selengkapnya",
          trimExpandedText: " Lihat Lebih Sedikit",
          moreStyle: AppTextStyle.ts10Bold,
          lessStyle: AppTextStyle.ts10Bold,
          trimMode: TrimMode.Line,
          trimLines: 8,
        ),
      ],
    );
  }
}
