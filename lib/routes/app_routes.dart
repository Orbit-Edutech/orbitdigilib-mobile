import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../pages/auth/auth_library_page.dart';
import '../pages/auth/auth_user_page.dart';
import '../pages/auth/binding/auth_binding.dart';
import '../pages/splash/binding/splash_binding.dart';
import '../pages/splash/splash_page.dart';

class AppRoutes {
  /// /splash
  static const String splash = "/splash";

  /// /auth-library
  static const String authLibrary = "/auth-library";

  /// /auth-user
  static const String authUser = "/auth-user";

  static final pages = <GetPage>[
    GetPage(
      name: splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 150),
    ),
    GetPage(
      name: authLibrary,
      page: () => const AuthLibraryPage(),
      binding: AuthBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 150),
    ),
    GetPage(
      name: authUser,
      page: () => const AuthUserPage(),
      binding: AuthBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 150),
    ),
  ];
}
