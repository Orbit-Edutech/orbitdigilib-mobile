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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Dirilis tanggal", style: AppTextStyle.ts10Bold),
                  Text("18 Maret 2024", style: AppTextStyle.ts10Reg),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Diupdate tanggal", style: AppTextStyle.ts10Bold),
                  Text("1 April 2024", style: AppTextStyle.ts10Reg),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
