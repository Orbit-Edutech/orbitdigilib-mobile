import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../widgets/search_filter_modal.dart';

class SearchPageController extends GetxController {
  final textController = TextEditingController();
  final focusNode = FocusNode();

  void showFilterModal() {
    Get.bottomSheet(
      const SearchFilterModal(),
      isScrollControlled: true,
      enableDrag: false,
    );
  }
}
