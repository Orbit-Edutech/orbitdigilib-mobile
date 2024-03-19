import 'package:get/instance_manager.dart';

import '../controller/navigator_controller.dart';

class NavigatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigatorController());
  }
}
