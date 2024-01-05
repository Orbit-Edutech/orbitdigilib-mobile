import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../api/api_client.dart';
import '../../../api/auth/data/auth_validate.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/shared_preferences_manager.dart';
import '../widget/splash_error_dialog.dart';

class SplashController extends GetxController {
  Rx<bool> isNoInternet = false.obs;
  Rx<ButtonState> buttonState = ButtonState.enable.obs;
  @override
  void onInit() async {
    buttonState.value = ButtonState.loading;
    await Future.delayed(const Duration(seconds: 2));
    final response = await authValidate();
    if (response.data != null) {
      final color = await SharedPreferencesManager.readPref<String>("color");
      await AppTheme.changePerpusTheme(color);
      Get.offAllNamed(AppRoutes.navigator);
    } else {
      if (response.error == ResponseStatus.connectionError) {
        Get.dialog(
          const SplashErrorDialog(),
          barrierDismissible: false,
        );
      } else {
        Get.offAllNamed(AppRoutes.authLibrary);
      }
    }
    super.onInit();
  }
}
