import 'package:get/instance_manager.dart';

import '../controller/about_library_controller.dart';

class AboutLibraryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutLibraryController());
  }
}
