import 'package:get/instance_manager.dart';

import '../controller/book_controller.dart';

class BookBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookController());
  }
}
