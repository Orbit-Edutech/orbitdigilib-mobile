import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../pages/auth/auth_library_page.dart';
import '../pages/auth/auth_user_page.dart';
import '../pages/auth/binding/auth_binding.dart';
import '../pages/books/books_page.dart';
import '../pages/highlight/highlight_page.dart';
import '../pages/index/binding/index_binding.dart';
import '../pages/index/index_page.dart';
import '../pages/notifications/binding/notifications_binding.dart';
import '../pages/notifications/notification_page.dart';
import '../pages/notifications/notifications_page.dart';
import '../pages/search/binding/seach_binding.dart';
import '../pages/search/search_page.dart';
import '../pages/splash/binding/splash_binding.dart';
import '../pages/splash/splash_page.dart';
import '../pages/token/binding/token_binding.dart';
import '../pages/token/token_page.dart';

class AppRoutes {
  /// /splash
  static const String splash = "/splash";

  /// /auth-library
  static const String authLibrary = "/auth-library";

  /// /auth-user
  static const String authUser = "/auth-user";

  /// /index
  static const String index = "/index";

  /// /search
  static const String search = "/search";

  /// /notifications
  static const String notifications = "/notifications";

  /// /notification
  static const String notification = "/notification";

  /// /token
  static const String token = "/token";

  /// /highlight
  static const String highlight = "/highlight";

  /// /books
  static const String books = "/books";

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
    GetPage(
      name: token,
      page: () => const TokenPage(),
      binding: TokenBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: highlight,
      page: () => const HighlightPage(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: search,
      page: () => const SearchPage(),
      binding: SearchBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: notifications,
      page: () => const NotificationsPage(),
      binding: NotificationsBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: notification,
      page: () => const NotificationPage(),
      binding: NotificationsBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: books,
      page: () => const BooksPage(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
  ];
}
