import 'package:get/instance_manager.dart';

import '../controller/transaksi_digital_controller.dart';

class TransaksiDigitalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransaksiDigitalController());
  }
}
