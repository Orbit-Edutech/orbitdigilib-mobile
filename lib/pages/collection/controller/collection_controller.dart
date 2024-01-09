import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CollectionController extends GetxController {
  Rx<String> filter = "Semua Koleksi".obs;
  // Rx<List<CollectionBooks>?> collectionBooks = Rx<List<CollectionBooks>?>(null);

  void onFilterChange(String filter) => this.filter.value = filter;
}
