import 'package:get/instance_manager.dart';

import '../controller/search_page_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchPageController());
  }
}
