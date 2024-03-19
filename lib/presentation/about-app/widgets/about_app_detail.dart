import 'package:flutter/material.dart';

import '../../../constants/gaps.dart';
import '../../../theme/app_text_stlye.dart';

class AboutAppDetail extends StatelessWidget {
  const AboutAppDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Detail Aplikasi", style: AppTextStyle.ts14Bold),
        VGap.s,
        Row(
          children: [
            // TODO: Jangan lupa ganti release date saat akan melakukan deployment
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Dirilis tanggal", style: AppTextStyle.ts10Bold),
                  Text("1 Januari 2024", style: AppTextStyle.ts10Reg),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Diupdate tanggal", style: AppTextStyle.ts10Bold),
                  Text("10 Januari 2024", style: AppTextStyle.ts10Reg),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
