import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../api/auth/data/auth_validate.dart';
import '../../../routes/app_routes.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/shared_preferences_manager.dart';

class SplashController extends GetxController {
  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 2));
    final response = await authValidate();
    if (response.data != null) {
      final color = await SharedPreferencesManager.readPref<String>("color");
      await AppTheme.changePerpusTheme(color);
      Get.offAllNamed(AppRoutes.index);
    } else {
      // TODO: Atasi error no internet
      Get.offAllNamed(AppRoutes.authLibrary);
    }
    super.onInit();
  }
}
