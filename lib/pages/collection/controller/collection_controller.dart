import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../api/koleksi/data/get_koleksi.dart';

class CollectionController extends GetxController {
  Rx<String> filter = "Semua Koleksi".obs;
  Rx<List<dynamic>?> collectionBooks = Rx<List<dynamic>?>(null);

  @override
  Future<void> onInit() async {
    collectionBooks.value = null;
    final response = await getCollections();
    if (response.data != null) {
      print(response.data);
      collectionBooks.value = response.data["payload"];
    } else {}
    super.onInit();
  }

  void onFilterChange(String filter) => this.filter.value = filter;
}
