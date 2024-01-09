import 'package:flutter/material.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import 'widgets/about_app_detail.dart';
import 'widgets/about_app_footer.dart';
import 'widgets/about_app_general.dart';
import 'widgets/about_app_release_note.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tentang Aplikasi")),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(Sizes.m),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AboutAppGeneral(),
            VGap.m,
            AboutAppDetail(),
            VGap.m,
            AboutAppReleaseNote(),
            VGap.h,
            AboutAppFooter(),
          ],
        ),
      ),
    );
  }
}
