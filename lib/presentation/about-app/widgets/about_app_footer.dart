import "dart:io";

import "package:flutter/gestures.dart";
import "package:flutter/material.dart";

import '../../../constants/app_info.dart';
import '../../../constants/gaps.dart';
import '../../../theme/app_text_stlye.dart';
import '../../../utils/launch_url.dart';

class AboutAppFooter extends StatelessWidget {
  const AboutAppFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text.rich(
          TextSpan(
            text: "Pelajari ",
            children: [
              TextSpan(
                text: "Kebijakan Privasi ",
                style: AppTextStyle.ts10Bold,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrl("https://orbitdigilib.com/kebijakanprivasi");
                  },
              ),
              const TextSpan(text: "serta "),
              TextSpan(
                text: "Syarat & Ketentuan ",
                style: AppTextStyle.ts10Bold,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    launchUrl("https://orbitdigilib.com/syaratdanketentuan");
                  },
              ),
              const TextSpan(text: "aplikasi"),
            ],
            style: AppTextStyle.ts10Reg,
          ),
          textAlign: TextAlign.center,
        ),
        VGap.m,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Versi Aplikasi", style: AppTextStyle.ts10Reg),
            HGap.xs,
            Text("v${Platform.isAndroid ? AppInfo.android.versionName : AppInfo.iOs.versionName}",
                style: AppTextStyle.ts10Bold),
          ],
        )
      ],
    );
  }
}
