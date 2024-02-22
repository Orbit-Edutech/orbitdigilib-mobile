import 'package:flutter/material.dart';

import '../../../constants/gaps.dart';
import '../../../theme/app_text_stlye.dart';

class ReleaseNote {
  String title;
  String? description;

  ReleaseNote({required this.title, this.description});
}

class AboutAppReleaseNote extends StatelessWidget {
  const AboutAppReleaseNote({super.key});

  @override
  Widget build(BuildContext context) {
    final releaseNotes = <ReleaseNote>[
      // ReleaseNote(title: "Title", description: "Description"),
      // ReleaseNote(title: "Title", description: "Description"),
      // ReleaseNote(title: "Title", description: "Description"),
    ];
    if (releaseNotes.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VGap.m,
        Text("Apa yang baru?", style: AppTextStyle.ts14Bold),
        VGap.s,
        for (ReleaseNote releaseNote in releaseNotes) ...[
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
                      releaseNote.title,
                      style: AppTextStyle.ts10Bold,
                    ),
                    Text(
                      releaseNote.description ?? "",
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
