import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_color.dart';

class AppTheme {
  static const textTheme = TextTheme();
  static final theme = ThemeData(
    scaffoldBackgroundColor: AppColor.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.lightBlue,
      primary: Colors.lightBlue.shade500,
    ),
    textTheme: GoogleFonts.robotoTextTheme(textTheme),
    useMaterial3: true,
  );
}
