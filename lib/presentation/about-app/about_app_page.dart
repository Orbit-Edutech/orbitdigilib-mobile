import 'package:flutter/material.dart';

import '../../constants/gaps.dart';
import '../../utils/responsive_helper.dart';
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
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxContentWidth(context),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(
              ResponsiveHelper.getHorizontalPadding(context),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AboutAppGeneral(),
                VGap.m,
                AboutAppDetail(),
                AboutAppReleaseNote(),
                VGap.h,
                AboutAppFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
