import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/route_manager.dart';

import '../theme/app_color.dart';
import '../utils/compute_luminance.dart';
import 'app_text_stlye.dart';

class AppTheme {
  static const textTheme = TextTheme();
  static final theme = ThemeData(
    scaffoldBackgroundColor: AppColor.bgScaffold,
    appBarTheme: AppBarTheme(
      toolbarHeight: 50,
      titleTextStyle: AppTextStyle.ts18Bold,
      backgroundColor: Colors.lightBlue.shade500,
      foregroundColor: calculateLuminance(Colors.lightBlue.shade500),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.lightBlue,
      primary: Colors.lightBlue.shade500,
    ),
    textTheme: GoogleFonts.robotoTextTheme(textTheme),
    useMaterial3: true,
  );

  static Future<ThemeData> changePerpusTheme([String? color]) async {
    final perpusColor = getPerpusColor(color ?? "Light Blue");
    const textTheme = TextTheme();
    final theme = ThemeData(
      scaffoldBackgroundColor: AppColor.bgScaffold,
      appBarTheme: AppBarTheme(
        toolbarHeight: 50,
        titleTextStyle: AppTextStyle.ts18Bold,
        backgroundColor: perpusColor.primary,
        foregroundColor: calculateLuminance(perpusColor.primary),
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: perpusColor.seed,
        primary: perpusColor.primary,
      ),
      textTheme: GoogleFonts.robotoTextTheme(textTheme),
      useMaterial3: true,
    );
    Get.changeTheme(theme);
    await Get.forceAppUpdate();
    return theme;
  }

  static PerpusColor getPerpusColor(String color) {
    switch (color) {
      case "Pink":
        return PerpusColor(seed: Colors.pink, primary: Colors.pink.shade500);
      case "Red":
        return PerpusColor(seed: Colors.red, primary: Colors.red.shade500);
      case "Deep Orange":
        return PerpusColor(seed: Colors.deepOrange, primary: Colors.deepOrange.shade500);
      case "Orange":
        return PerpusColor(seed: Colors.orange, primary: Colors.orange.shade500);
      case "Amber":
        return PerpusColor(seed: Colors.amber, primary: Colors.amber.shade500);
      case "Yellow":
        return PerpusColor(seed: Colors.yellow, primary: Colors.yellow.shade500);
      case "Lime":
        return PerpusColor(seed: Colors.lime, primary: Colors.lime.shade500);
      case "Light Green":
        return PerpusColor(seed: Colors.lightGreen, primary: Colors.lightGreen.shade500);
      case "Green":
        return PerpusColor(seed: Colors.green, primary: Colors.green.shade500);
      case "Teal":
        return PerpusColor(seed: Colors.teal, primary: Colors.teal.shade500);
      case "Cyan":
        return PerpusColor(seed: Colors.cyan, primary: Colors.cyan.shade500);
      case "Light Blue":
        return PerpusColor(seed: Colors.lightBlue, primary: Colors.lightBlue.shade500);
      case "Blue":
        return PerpusColor(seed: Colors.blue, primary: Colors.blue.shade500);
      case "Indigo":
        return PerpusColor(seed: Colors.indigo, primary: Colors.indigo.shade500);
      case "Purple":
        return PerpusColor(seed: Colors.purple, primary: Colors.purple.shade500);
      case "Deep Purple":
        return PerpusColor(seed: Colors.deepPurple, primary: Colors.deepPurple.shade500);
      case "Blue Grey":
        return PerpusColor(seed: Colors.blueGrey, primary: Colors.blueGrey.shade500);
      case "Brown":
        return PerpusColor(seed: Colors.brown, primary: Colors.brown.shade500);
      case "Grey":
        return PerpusColor(seed: Colors.grey, primary: Colors.grey.shade500);
      default:
        return PerpusColor(seed: Colors.lightBlue, primary: Colors.lightBlue.shade700);
    }
  }
}

class PerpusColor {
  final Color seed;
  final Color primary;

  PerpusColor({required this.seed, required this.primary});
}
