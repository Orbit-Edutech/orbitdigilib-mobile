import 'package:get/instance_manager.dart';

import '../controller/wishlist_controller.dart';

class WishlistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WishlistController());
  }
}
