import 'package:get/instance_manager.dart';

import '../controller/books_controller.dart';

class BooksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BooksController());
  }
}
