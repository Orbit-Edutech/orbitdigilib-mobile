import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../pages/auth/auth_library_page.dart';
import '../pages/auth/auth_user_page.dart';
import '../pages/auth/binding/auth_binding.dart';
import '../pages/index/binding/index_binding.dart';
import '../pages/index/index_page.dart';
import '../pages/splash/binding/splash_binding.dart';
import '../pages/splash/splash_page.dart';

class AppRoutes {
  /// /splash
  static const String splash = "/splash";

  /// /auth-library
  static const String authLibrary = "/auth-library";

  /// /auth-user
  static const String authUser = "/auth-user";

  /// /index
  static const String index = "/index";

  static final pages = <GetPage>[
    GetPage(
      name: splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: authLibrary,
      page: () => const AuthLibraryPage(),
      binding: AuthBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: authUser,
      page: () => const AuthUserPage(),
      binding: AuthBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: index,
      page: () => const IndexPage(),
      binding: IndexBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
  ];
}
