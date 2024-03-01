import 'package:flutter/material.dart';

import '../../../api/buku-perpustakaan/model/model_one_buku_perpustakaan.dart';
import '../../../constants/gaps.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class BookAbout extends StatelessWidget {
  const BookAbout({
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
          "Tentang Buku",
          style: AppTextStyle.ts14Bold,
          textAlign: TextAlign.center,
        ),
        VGap.s,
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Jumlah Halaman",
                    style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                  ),
                  Text(
                    "${book?.jumlahHalaman ?? "-"}",
                    style: AppTextStyle.ts12Bold.copyWith(color: AppColor.grey),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Penerbit",
                    style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                  ),
                  Text(
                    book?.penerbit?.nama ?? "-",
                    style: AppTextStyle.ts12Bold.copyWith(color: AppColor.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
        VGap.r,
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tahun Terbit",
                    style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                  ),
                  Text(
                    book?.tahunTerbit ?? "-",
                    style: AppTextStyle.ts12Bold.copyWith(color: AppColor.grey),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bahasa",
                    style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                  ),
                  Text(
                    book?.bahasa?.bahasaResmi ?? "-",
                    style: AppTextStyle.ts12Bold.copyWith(color: AppColor.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
        VGap.r,
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ISBN",
                    style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                  ),
                  Text(
                    book?.isbn ?? '-',
                    style: AppTextStyle.ts12Bold.copyWith(color: AppColor.grey),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "E-ISBN",
                    style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                  ),
                  Text(
                    book?.eIsbn ?? "-",
                    style: AppTextStyle.ts12Bold.copyWith(color: AppColor.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
