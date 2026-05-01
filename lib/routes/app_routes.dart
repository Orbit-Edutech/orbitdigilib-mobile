import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../presentation/about-app/about_app_page.dart';
import '../presentation/about-library/about_library_page.dart';
import '../presentation/about-library/binding/about_library_binding.dart';
import '../presentation/tata-tertib/binding/tata_tertib_binding.dart';
import '../presentation/tata-tertib/tata_tertib_page.dart';
import '../presentation/history-buku/binding/history_buku_binding.dart';
import '../presentation/history-buku/history_buku_page.dart';
import '../presentation/auth/auth_library_page.dart';
import '../presentation/auth/auth_user_page.dart';
import '../presentation/auth/auth_register_page.dart';
import '../presentation/auth/binding/auth_binding.dart';
import '../presentation/book/binding/book_binding.dart';
import '../presentation/book/book_page.dart';
import '../presentation/books/binding/books_binding.dart';
import '../presentation/books/books_page.dart';
import '../presentation/category/binding/category_binding.dart';
import '../presentation/category/category_page.dart';
import '../presentation/faq/binding/faq_binding.dart';
import '../presentation/faq/faq_page.dart';
import '../presentation/highlight/highlight_page.dart';
import '../presentation/index/binding/index_binding.dart';
import '../presentation/index/index_page.dart';
import '../presentation/navigator/binding/navigator_binding.dart';
import '../presentation/navigator/navigator_page.dart';
import '../presentation/notification/binding/notifications_binding.dart';
import '../presentation/notification/notifications_page.dart';
import '../presentation/offline-read/binding/offline_read_binding.dart';
import '../presentation/offline-read/offline_read.dart';
import '../presentation/offline/binding/offline_binding.dart';
import '../presentation/offline/offline_page.dart';
import '../presentation/profile/profile_page.dart';
import '../presentation/change-password/binding/change_password_binding.dart';
import '../presentation/change-password/change_password_page.dart';
import '../presentation/read-collection/binding/read_collection_binding.dart';
import '../presentation/read-collection/read_collection_page.dart';
import '../presentation/read/binding/read_binding.dart';
import '../presentation/read/read_page.dart';
import '../presentation/recommendation/binding/recommendation_binding.dart';
import '../presentation/recommendation/recommendation_page.dart';
import '../presentation/search/binding/seach_binding.dart';
import '../presentation/search/search_page.dart';
import '../presentation/splash/binding/splash_binding.dart';
import '../presentation/splash/splash_page.dart';
import '../presentation/token/binding/token_binding.dart';
import '../presentation/token/token_page.dart';
import '../presentation/update/update_page.dart';
import '../presentation/wishlist/binding/wishlist_binding.dart';
import '../presentation/wishlist/wishlist_page.dart';

class AppRoutes {
  /// /splash
  static const String splash = "/splash";

  /// /offline
  static const String offline = "/offline";

  /// /offline-read
  static const String offlineRead = "/offline-read";

  /// /update
  static const String update = "/update";

  /// /auth-library
  static const String authLibrary = "/auth-library";

  /// /auth-user
  static const String authUser = "/auth-user";

  /// /auth-register
  static const String authRegister = "/auth-register";

  /// /
  static const String navigator = "/";

  /// /index
  static const String index = "/index";

  /// /search
  static const String search = "/search";

  /// /notifications
  static const String notifications = "/notifications";

  /// /token
  static const String token = "/token";

  /// /highlight
  static const String highlight = "/highlight";

  /// /books
  static const String books = "/books";

  /// /book
  static const String book = "/book";

  /// /read
  static const String read = "/read";

  /// /read-collection
  static const String readCollection = "/read-collection";

  /// /category
  static const String category = "/category";

  /// /recommendation
  static const String recommendation = "/recommendation";

  /// /wishlist
  static const String wishlist = "/wishlist";

  /// /profile
  static const String profile = "/profile";

  /// /reset-password
  static const String resetPassword = "/reset-password";

  /// /faq
  static const String faq = "/faq";

  /// /about-app
  static const String aboutApp = "/about-app";

  /// /about-library
  static const String aboutLibrary = "/about-library";

  /// /tata-tertib
  static const String tataTertib = "/tata-tertib";

  /// /history-buku
  static const String historyBuku = "/history-buku";

  static final pages = <GetPage>[
    GetPage(
      name: splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: offline,
      page: () => const OfflinePage(),
      binding: OfflineBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: offlineRead,
      page: () => const OfflineReadPage(),
      binding: OfflineReadBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: update,
      page: () => const UpdatePage(),
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
      name: authRegister,
      page: () => const AuthRegisterPage(),
      binding: AuthBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: navigator,
      page: () => const NavigatorPage(),
      binding: NavigatorBinding(),
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
      name: books,
      page: () => const BooksPage(),
      binding: BooksBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: book,
      page: () => const BookPage(),
      binding: BookBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: read,
      page: () => const ReadPage(),
      binding: ReadBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: readCollection,
      page: () => const ReadCollectionPage(),
      binding: ReadCollectionBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: category,
      page: () => const CategoryPage(),
      binding: CategoryBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: recommendation,
      page: () => const RecommendationPage(),
      binding: RecommendationBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: wishlist,
      page: () => const WishlistPage(),
      binding: WishlistBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: profile,
      page: () => const ProfilePage(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: resetPassword,
      page: () => const ChangePasswordPage(),
      binding: ChangePasswordBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: faq,
      page: () => const FAQPage(),
      binding: FAQBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: aboutApp,
      page: () => const AboutAppPage(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: aboutLibrary,
      page: () => const AboutLibraryPage(),
      binding: AboutLibraryBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: tataTertib,
      page: () => const TataTertibPage(),
      binding: TataTertibBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
    GetPage(
      name: historyBuku,
      page: () => const HistoryBukuPage(),
      binding: HistoryBukuBinding(),
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
    ),
  ];
}
