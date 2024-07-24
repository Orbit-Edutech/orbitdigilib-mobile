import 'dart:io';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../api/api_client.dart';
import '../../../api/auth/data/auth_validate.dart';
import '../../../api/auth/model/model_auth_validate.dart';
import '../../../constants/app_info.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/shared_preferences_manager.dart';
import '../widget/splash_error_dialog.dart';

class SplashController extends GetxController {
  Rx<bool> isNoInternet = false.obs;
  Rx<ButtonState> buttonState = ButtonState.enable.obs;
  AuthValidate? validate;
  @override
  void onInit() async {
    buttonState.value = ButtonState.loading;
    await Future.delayed(const Duration(seconds: 1));
    final response = await authValidate();
    if (response.data != null) {
      validate = response.data;
      final isUpdateAvailable = checkUpdateStatus();
      if (isUpdateAvailable) {
        Get.offAllNamed(AppRoutes.update);
      } else {
        final color = await SharedPreferencesManager.readPref<String>("color");
        await AppTheme.changePerpusTheme(color);
        Get.offAllNamed(AppRoutes.navigator);
      }
    } else {
      if (response.error == ResponseStatus.connectionError) {
        final color = await SharedPreferencesManager.readPref<String>("color");
        await AppTheme.changePerpusTheme(color);
        Get.dialog(const SplashErrorDialog(), barrierDismissible: false);
      } else {
        Get.offAllNamed(AppRoutes.authLibrary);
      }
    }

    // final color = await SharedPreferencesManager.readPref<String>("color");
    // await AppTheme.changePerpusTheme(color);
    // Get.dialog(const SplashErrorDialog(), barrierDismissible: false);

    super.onInit();
  }

  /// Akan mengembalikan nilai [True] jika terdapat versi yang terbaru
  bool checkUpdateStatus() {
    if (Platform.isAndroid) {
      final int localVersion = AppInfo.android.versionCode!;
      final int productionVersion = validate?.version?.android?.versionCode ?? 1;
      if (localVersion < productionVersion) {
        return true;
      } else {
        return false;
      }
    } else if (Platform.isIOS) {
      final int localVersion = AppInfo.iOs.versionCode!;
      final int productionVersion = validate?.version?.iOs?.versionCode ?? 1;
      if (localVersion < productionVersion) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
