import 'package:get/instance_manager.dart';

import '../pages/index/controller/index_controller.dart';
import '../pages/wishlist/controller/wishlist_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(IndexController());
    Get.put(WishlistController());
  }
}
