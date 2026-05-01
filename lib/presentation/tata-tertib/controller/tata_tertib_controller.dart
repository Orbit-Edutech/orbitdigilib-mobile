import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../api/api_client.dart';
import '../../../api/perpustakaan/data/perpustakaan_get_one.dart';
import '../../../api/perpustakaan/model/model_perpustakaan.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';
import '../../../utils/shared_preferences_manager.dart';

class TataTertibController extends GetxController {
  Rx<Perpustakaan?> perpustakaan = Rx<Perpustakaan?>(null);

  @override
  Future<void> onInit() async {
    final String? kodePerpustakaan = await SharedPreferencesManager.readPref("kodePerpustakaan");
    final response = await getOnePerpustakaan(kode: kodePerpustakaan ?? "");
    if (response.data != null) {
      perpustakaan.value = response.data;
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
