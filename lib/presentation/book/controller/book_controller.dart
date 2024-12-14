import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../../api/buku-perpustakaan/data/buku_perpustakaan_get_one.dart';
import '../../../api/buku-perpustakaan/model/model_all_buku_perpustakaan.dart' as a;
import '../../../api/buku-perpustakaan/model/model_one_buku_perpustakaan.dart';
import '../../../api/koleksi/data/check_collection.dart';
import '../../../api/transaksi/data/beli_create_one.dart';
import '../../../api/transaksi/data/pinjam_create_one.dart';
import '../../../api/transaksi/data/sewa_create_one.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';
import '../../collection/controller/collection_controller.dart';
import '../../index/controller/index_controller.dart';
import '../../profile/controller/profile_controller.dart';
import '../widgets/book_read_options.dart';

class BookController extends GetxController {
  final collectionController = Get.find<CollectionController>();
  final profileController = Get.find<ProfileController>();
  final perpustakaan = Get.find<IndexController>().perpustakaan.value;

  a.Payload? args;
  Rx<BukuPerpustakaan?> book = Rx<BukuPerpustakaan?>(null);
  Rx<bool> isInCollections = false.obs;

  Rx<String?> optionSelected = Rx<String?>(null);
  Rx<ButtonState> buttonState = ButtonState.disable.obs;

  @override
  Future<void> onInit() async {
    args = Get.arguments;
    final response = await getOneBukuPerpustakaan(args!.id!);
    final check = await checkCollection(args!.buku!.id!);
    if (check.data != null) isInCollections.value = true;
    if (response.data != null) {
      book.value = response.data;
    } else {
      showSnackbar(message: "Terjadi kesalahan", backgroundColor: AppColor.red);
    }
    super.onInit();
  }

  void submitOption() async {
    buttonState.value = ButtonState.loading;
    await Future.delayed(const Duration(seconds: 1));
    switch (optionSelected.value) {
      case "Pinjam":
        await pinjamBuku();
        break;
      case "Sewa":
        await sewaBuku();
        break;
      case "Beli":
        await beliBuku();
        break;
      default:
    }
    buttonState.value = ButtonState.enable;
  }

  Future<void> pinjamBuku() async {
    final response = await pinjamCreateOne(args?.id ?? "");
    if (response.data != null) {
      collectionController.onInit();
      showSnackbar(message: "Buku berhasil ditambahkan ke Koleksi!", backgroundColor: AppColor.green);
      Get.offNamed(AppRoutes.read, arguments: {"asset": book.value?.buku?.id, "type": "read"});
      final check = await checkCollection(args!.buku!.id!);
      if (check.data != null) isInCollections.value = true;
      profileController.onInit();
    } else {
      showSnackbar(message: response.error["message"], backgroundColor: AppColor.red);
    }
  }

  Future<void> sewaBuku() async {
    final response = await sewaCreateOne(args?.buku?.id ?? "");
    if (response.data != null) {
      collectionController.onInit();
      showSnackbar(message: "Buku berhasil ditambahkan ke Koleksi!", backgroundColor: AppColor.green);
      Get.offNamed(AppRoutes.read, arguments: {"asset": book.value?.buku?.id, "type": "read"});
      final check = await checkCollection(args!.buku!.id!);
      if (check.data != null) isInCollections.value = true;
      profileController.onInit();
    } else {
      showSnackbar(message: response.error["message"], backgroundColor: AppColor.red);
    }
  }

  Future<void> beliBuku() async {
    final response = await beliCreateOne(args?.buku?.id ?? "");
    if (response.data != null) {
      collectionController.onInit();
      showSnackbar(message: "Buku berhasil ditambahkan ke Koleksi!", backgroundColor: AppColor.green);
      Get.offNamed(AppRoutes.read, arguments: {"asset": book.value?.buku?.id, "type": "read"});
      final check = await checkCollection(args!.buku!.id!);
      if (check.data != null) isInCollections.value = true;
      profileController.onInit();
    } else {
      showSnackbar(message: response.error["message"], backgroundColor: AppColor.red);
    }
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
