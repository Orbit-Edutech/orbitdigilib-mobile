import 'package:get/instance_manager.dart';

import '../controller/token_controller.dart';

class TokenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TokenController());
  }
}
