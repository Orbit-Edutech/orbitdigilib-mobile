import 'package:flutter/material.dart';

import '../../constants/gaps.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/icon.png", width: size.width / 4),
            VGap.s,
            Image.asset("assets/icons/text-icon.png", width: size.width / 4),
          ],
        ),
      ),
    );
  }
}
