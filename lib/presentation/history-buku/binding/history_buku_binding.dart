import 'package:get/instance_manager.dart';

import '../controller/history_buku_controller.dart';

class HistoryBukuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HistoryBukuController());
  }
}
