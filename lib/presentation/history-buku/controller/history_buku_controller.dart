import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../api/api_client.dart';
import '../../../api/laporan-literasi/data/get_ringkasan_bacaan.dart';
import '../../../api/laporan-literasi/model/model_ringkasan_bacaan.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';

class HistoryBukuController extends GetxController {
  Rx<RingkasanBacaan?> ringkasan = Rx<RingkasanBacaan?>(null);
  RxBool isLoading = true.obs;

  @override
  Future<void> onInit() async {
    await fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    isLoading.value = true;
    final response = await getRingkasanBacaan();
    if (response.data != null) {
      ringkasan.value = response.data;
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
    isLoading.value = false;
  }
}
