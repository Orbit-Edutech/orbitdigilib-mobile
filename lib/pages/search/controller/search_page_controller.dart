import 'package:flutter/widgets.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../widgets/search_filter_modal.dart';

class SearchPageController extends GetxController {
  String filterLetter = "";

  final textController = TextEditingController();
  final lowerPriceTextController = TextEditingController();
  final higherPriceTextController = TextEditingController();

  final searchFocusNode = FocusNode();
  final lowerPriceFocusNode = FocusNode();
  final higherPriceFocusNode = FocusNode();

  void clearPrice() {
    lowerPriceFocusNode.unfocus();
    higherPriceFocusNode.unfocus();
    lowerPriceTextController.clear();
    higherPriceTextController.clear();
  }

  void showFilterModal() {
    Get.bottomSheet(
      const SearchFilterModal(),
      isScrollControlled: true,
      enableDrag: false,
    );
  }
}
