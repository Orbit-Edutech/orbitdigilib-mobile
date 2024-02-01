import 'package:get/instance_manager.dart';

import '../controller/auth_library_controller.dart';
import '../controller/auth_user_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthLibraryController());
    Get.lazyPut(() => AuthUserController());
  }
}
