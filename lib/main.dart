import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'constants/app_info.dart';
import 'routes/app_bindings.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'utils/image_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
    try {
      sqfliteFfiInit();
    } catch (e) {
      debugPrint('Error initializing sqflite FFI: $e');
    }
  }
  
  runApp(const MyApp());
  ImageUtils.prechacheImages();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppInfo.name,
      theme: AppTheme.theme,
      themeMode: ThemeMode.light,
      initialBinding: AppBindings(),
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.splash,
    );
  }
}
