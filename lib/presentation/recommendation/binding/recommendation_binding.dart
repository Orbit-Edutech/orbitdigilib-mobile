import 'package:get/instance_manager.dart';

import '../controller/recommendation_controller.dart';

class RecommendationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecommendationController());
  }
}
