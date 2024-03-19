import 'package:get/instance_manager.dart';

import '../controller/index_controller.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexController());
  }
}
