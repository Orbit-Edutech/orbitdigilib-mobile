import 'package:flutter/material.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_text_stlye.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detil Notifikasi"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Sizes.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Judul Notifikasi", style: AppTextStyle.ts18Bold),
            VGap.r,
            const Text(
              "I'm unable to find a way to create an input field in Flutter that would open up a numeric keyboard and should take numeric input only. Is this possible with Flutter material widgets? Some GitHub discussions seem to indicate this is a supported feature but I'm unable to find any documentation about it. I'm unable to find a way to create an input field in Flutter that would open up a numeric keyboard and should take numeric input only. Is this possible with Flutter material widgets? Some GitHub discussions seem to indicate this is a supported feature but I'm unable to find any documentation about it. I'm unable to find a way to create an input field in Flutter that would open up a numeric keyboard and should take numeric input only. Is this possible with Flutter material widgets? Some GitHub discussions seem to indicate this is a supported feature but I'm unable to find any documentation about it. I'm unable to find a way to create an input field in Flutter that would open up a numeric keyboard and should take numeric input only. Is this possible with Flutter material widgets? Some GitHub discussions seem to indicate this is a supported feature but I'm unable to find any documentation about it. I'm unable to find a way to create an input field in Flutter that would open up a numeric keyboard and should take numeric input only. Is this possible with Flutter material widgets? Some GitHub discussions seem to indicate this is a supported feature but I'm unable to find any documentation about it.",
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
