import 'package:get/instance_manager.dart';

import '../controller/offline_read_controller.dart';

class OfflineReadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OfflineReadController());
  }
}
