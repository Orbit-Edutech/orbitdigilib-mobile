import 'package:flutter/material.dart';

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
            const SizedBox(height: 8),
            Image.asset("assets/icons/text-icon.png", width: size.width / 4),
          ],
        ),
      ),
    );
  }
}
