import 'package:flutter/material.dart';

import '../../../constants/gaps.dart';
import '../../../theme/app_text_stlye.dart';

class AboutAppReleaseNote extends StatelessWidget {
  const AboutAppReleaseNote({super.key});

  @override
  Widget build(BuildContext context) {
    final releaseNotes = [];
    if (releaseNotes.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Apa yang baru?", style: AppTextStyle.ts14Bold),
        VGap.s,
        for (var _ in releaseNotes) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "•",
                style: AppTextStyle.ts10Bold,
              ),
              HGap.s,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Penambahan Fitur Lorem Ipsum",
                      style: AppTextStyle.ts10Bold,
                    ),
                    Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                      style: AppTextStyle.ts10Light,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
          VGap.s,
        ]
      ],
    );
  }
}
