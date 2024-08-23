import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'constants/app_info.dart';
import 'routes/app_bindings.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'utils/image_utils.dart';

void main() async {
  runApp(const MyApp());
  ImageUtils.prechacheImages();
}

// TODO: Screenshot masih delay pada iOS halaman membaca

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
