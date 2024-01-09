import 'dart:developer';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../api/api_client.dart';
import '../../../api/faq/data/get_faq.dart';
import '../../../api/faq/model/model_faq.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';

class FAQController extends GetxController {
  Rx<List<FAQ>?> listFAQ = Rx<List<FAQ>?>(null);
  Rx<FAQ?> currentFAQ = Rx<FAQ?>(null);
  set setCurrentFAQ(FAQ faq) => currentFAQ.value = faq;
  @override
  Future<void> onInit() async {
    final response = await getFaq();
    if (response.data != null) {
      listFAQ.value = response.data!.listFaq;
      log(listFAQ.value.toString());
    } else {
      if (response.error == ResponseStatus.connectionError) {
        showSnackbar(
          backgroundColor: AppColor.red,
          message: "Terjadi kesalahan koneksi",
        );
      } else {
        showSnackbar(
          backgroundColor: AppColor.red,
          title: "Error ${response.statusCode}",
          message: response.error["message"],
        );
      }
    }
    super.onInit();
  }
}
