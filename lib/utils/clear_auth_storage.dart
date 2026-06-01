import 'shared_preferences_manager.dart';

Future<void> clearAuthStorage() async {
  await SharedPreferencesManager.writePrefs({
    "isLogin": false,
    "access": "",
    "refresh": "",
  });
}
