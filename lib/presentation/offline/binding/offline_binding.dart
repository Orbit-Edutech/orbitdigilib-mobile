import 'package:get/instance_manager.dart';

import '../controller/offline_controller.dart';

class OfflineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OfflinePageController());
  }
}
