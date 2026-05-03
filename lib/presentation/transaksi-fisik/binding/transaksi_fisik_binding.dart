import 'package:get/instance_manager.dart';

import '../controller/transaksi_fisik_controller.dart';

class TransaksiFisikBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransaksiFisikController());
  }
}
