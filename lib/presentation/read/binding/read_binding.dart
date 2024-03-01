import 'package:get/instance_manager.dart';

import '../controller/read_controller.dart';

class ReadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReadController());
  }
}
