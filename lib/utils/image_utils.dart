import 'package:flutter_svg/svg.dart';

class ImageUtils {
  static const String authOffice = "assets/illustrations/office.svg";
  static const String authChart = "assets/illustrations/chart.svg";
  static const String whatsapp = "assets/icons/whatsapp.svg";
  static const String allCategory = "assets/icons/all-category.svg";
  static const String categoryBg = "assets/icons/category-bg.svg";
  static const String coin = "assets/icons/coin.svg";
  static const String token = "assets/illustrations/token.svg";
  static const String notifications = "assets/icons/notifications.svg";
  static const String notificationsUnread = "assets/icons/notifications-unread.svg";

  static void prechacheImages() {
    const images = [authOffice, authChart, whatsapp, allCategory, categoryBg, coin, notifications, notificationsUnread];
    for (String image in images) {
      final loader = SvgAssetLoader(image);
      svg.cache.putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
  }
}
