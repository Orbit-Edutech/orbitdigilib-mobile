import 'package:get/instance_manager.dart';

import '../controller/read_collection_controller.dart';

class ReadCollectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReadCollectionController());
  }
}
