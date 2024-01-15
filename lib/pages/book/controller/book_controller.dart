import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../api/buku-perpustakaan/data/buku_perpustakaan_get_one.dart';
import '../../../api/buku-perpustakaan/model/model_all_buku_perpustakaan.dart' as a;
import '../../../api/buku-perpustakaan/model/model_one_buku_perpustakaan.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';
import '../widgets/book_read_options.dart';

class BookController extends GetxController {
  Rx<BukuPerpustakaan?> book = Rx<BukuPerpustakaan?>(null);

  Rx<String?> optionSelected = Rx<String?>(null);
  // Rx<ButtonState> buttonState = ButtonState.disable.obs;
  // void onOptionChange(String option) {
  //   optionSelected.value = option;

  // }

  @override
  Future<void> onInit() async {
    final a.Payload args = Get.arguments;
    final response = await getOneBukuPerpustakaan(args.id!);
    if (response.data != null) {
      book.value = response.data;
    } else {
      showSnackbar(message: "Terjadi kesalahan", backgroundColor: AppColor.red);
    }
    super.onInit();
  }

  void showOptions() async {
    Get.bottomSheet(
      BookReadOptions(
        payload: book.value,
      ),
      enableDrag: false,
      isScrollControlled: true,
    );
  }
}
