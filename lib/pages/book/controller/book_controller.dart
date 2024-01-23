import 'dart:developer';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';

import '../../../api/buku-perpustakaan/data/buku_perpustakaan_get_one.dart';
import '../../../api/buku-perpustakaan/model/model_all_buku_perpustakaan.dart' as a;
import '../../../api/buku-perpustakaan/model/model_one_buku_perpustakaan.dart';
import '../../../api/koleksi/data/check_collection.dart';
import '../../../api/transaksi/data/pinjam_create_one.dart';
import '../../../api/transaksi/data/sewa_create_one.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../theme/app_color.dart';
import '../widgets/book_read_options.dart';

class BookController extends GetxController {
  a.Payload? args;
  Rx<BukuPerpustakaan?> book = Rx<BukuPerpustakaan?>(null);
  Rx<bool> isInCollections = false.obs;

  Rx<String?> optionSelected = Rx<String?>(null);
  Rx<ButtonState> buttonState = ButtonState.disable.obs;

  @override
  Future<void> onInit() async {
    args = Get.arguments;
    final response = await getOneBukuPerpustakaan(args!.id!);
    log(args!.buku!.id!);
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
        break;
      default:
    }
    buttonState.value = ButtonState.enable;
  }

  Future<void> pinjamBuku() async {
    final response = await pinjamCreateOne(args?.id ?? "");
    if (response.data != null) {
      showSnackbar(message: "Buku berhasil ditambahkan ke Koleksi!", backgroundColor: AppColor.green);
    } else {
      showSnackbar(message: response.error["message"], backgroundColor: AppColor.red);
    }
  }

  Future<void> sewaBuku() async {
    final response = await sewaCreateOne(args?.buku?.id ?? "");
    if (response.data != null) {
      showSnackbar(message: "Buku berhasil ditambahkan ke Koleksi!", backgroundColor: AppColor.green);
      Get.offNamed(AppRoutes.read, arguments: book.value?.buku?.id);
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

var sewa = {
  "name": "sewa.createOne | Create One Sewa",
  "type": "Success",
  "statusCode": 201,
  "result": {
    "id": "4d5d5877-e4ec-4a69-80c7-0ddf44203ffe",
    "createdAt": "2024-01-18T08:52:30.413Z",
    "updatedAt": "2024-01-18T08:52:30.413Z",
    "hargaSewa": 50,
    "tanggalSewa": "2024-01-18T08:52:30.415Z",
    "tanggalHabisSewa": "2024-01-25T08:52:30.415Z",
    "user": {
      "id": "6d2ac251-c6a9-4fc8-87bd-cf95229b0fa4",
      "username": "angga",
      "passwordUpdatedAt": null,
      "email": "angga@gmail.com",
      "nama": "Anggakara Purpur",
      "jenisKelamin": "Laki",
      "urlFotoProfil": null,
      "tokenForgotPassword": null,
      "tokenForgotPasswordExpiredAt": null,
      "token": "928219.00",
      "role": {"nama": "Anggota"}
    },
    "buku": {
      "id": "47789b2b-c5d4-47a4-bc9e-7572fe336ae1",
      "judul": "Hukum Pidana Adat",
      "jumlahHalaman": 100,
      "tahunTerbit": "2020",
      "bahasa": "Indonesia",
      "penulis": "Erdianto Effendi",
      "hargaBeli": "40000",
      "hargaSewa": "5000",
      "assetSampulId": "bce7d0c5-48eb-4738-8344-8cf795228fc5"
    }
  }
};
