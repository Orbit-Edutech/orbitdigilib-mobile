import 'package:flutter/material.dart';

import '../../../constants/gaps.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class AboutAppGeneral extends StatelessWidget {
  const AboutAppGeneral({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage("assets/icons/icon.png"),
            ),
          ),
        ),
        Text("ORBIT DIGILIB", style: AppTextStyle.ts24Bold),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Dikembangkan oleh ", style: AppTextStyle.ts12Reg),
            Text(
              "Orbit360",
              style: AppTextStyle.ts12Bold.copyWith(color: AppColor.orange),
            ),
          ],
        ),
        VGap.s,
        Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised i",
          style: AppTextStyle.ts10Light,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}
