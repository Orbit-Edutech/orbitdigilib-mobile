import 'package:get/instance_manager.dart';

import '../controller/faq_controller.dart';

class FAQBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FAQController());
  }
}
