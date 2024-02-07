import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/gaps.dart';
import '../../shared/widget/app_button.dart';
import '../../utils/launch_url.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset("assets/illustrations/empty.svg"),
              VGap.s,
              const Text("Versi terbaru dari Orbit DIGILIB telah tersedia!"),
              VGap.m,
              AppButton(
                type: ButtonType.elevated,
                onPressed: () {
                  String url = "";
                  if (Platform.isAndroid) {
                    url = "market://details?id=com.orbit360.digilib";
                  } else if (Platform.isIOS) {
                    url = "https://apps.apple.com/app/id"; //TODO Tambahin ID
                  }
                  launchUrl(url);
                },
                child: const Text("Perbarui Sekarang"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
