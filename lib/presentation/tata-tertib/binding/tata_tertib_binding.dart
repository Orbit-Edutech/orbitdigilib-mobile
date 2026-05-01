import 'package:get/instance_manager.dart';

import '../controller/tata_tertib_controller.dart';

class TataTertibBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TataTertibController());
  }
}
