import 'package:flutter/material.dart';

class AppColor {
  static const Color def = Color(0xFF3DA3DC);
  static const Color bgScaffold = Color(0xFFFAFAFA);
  static const Color primary = Color(0xFF00b5ad);
  static const Color primary10 = Color(0xFFEBF8F0);
  static const Color white = Color(0xFFFEFEFE);
  static const Color black = Color(0xFF141414);
  static const Color grey = Color(0xFF757575);
  static const Color lightGrey = Color(0xFFC4C4C4);
  static const Color red = Color(0xFFFF1744);
  static const Color green = Color(0xFF00E676);
  static const Color orange = Color(0xFFfBA31C);
  static const Color whatsapp = Color(0xFF00E676);

  static const MaterialColor grabColors = MaterialColor(
    greenGrab,
    <int, Color>{
      50: Color(0xFFE0F2E9),
      100: Color(0xFFB3E0C8),
      200: Color(0xFF80CCAA),
      300: Color(0xFF4DB98B),
      400: Color(0xFF26AB74),
      500: Color(greenGrab),
      600: Color(0xFF009E47),
      700: Color(0xFF00883D),
      800: Color(0xFF007234),
      900: Color(0xFF004F23),
    },
  );
  static const int greenGrab = 0xFF00B14F;

  static const MaterialColor garudaColors = MaterialColor(
    garuda,
    <int, Color>{
      50: Color(0xFFE0F2F3),
      100: Color(0xFFB3DEE0),
      200: Color(0xFF80C7CC),
      300: Color(0xFF4DB0B8),
      400: Color(0xFF269EA8),
      500: Color(garuda),
      600: Color(0xFF137A83),
      700: Color(0xFF116A72),
      800: Color(0xFF0E5A62),
      900: Color(0xFF0A4145),
    },
  );
  static const int garuda = 0xFF158694;

  static const MaterialColor blueBirdColors = MaterialColor(
    blueBird,
    <int, Color>{
      50: Color(0xFFE1F0FA),
      100: Color(0xFFB3D9F2),
      200: Color(0xFF80BFEB),
      300: Color(0xFF4DA5E3),
      400: Color(0xFF2690DD),
      500: Color(blueBird),
      600: Color(0xFF0A579C),
      700: Color(0xFF084C89),
      800: Color(0xFF074276),
      900: Color(0xFF05315A),
    },
  );
  static const int blueBird = 0xFF0B62AC;
}
