import 'package:get/get.dart';

import '../controller/buy_token_controller.dart';

class BuyTokenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BuyTokenController());
  }
}
