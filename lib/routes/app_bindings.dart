import 'package:get/instance_manager.dart';

import '../presentation/collection/controller/collection_controller.dart';
import '../presentation/index/controller/index_controller.dart';
import '../presentation/profile/controller/profile_controller.dart';
import '../presentation/wishlist/controller/wishlist_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexController(), fenix: true);
    Get.lazyPut(() => WishlistController(), fenix: true);
    Get.lazyPut(() => CollectionController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
  }
}
