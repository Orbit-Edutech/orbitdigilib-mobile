import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../api/buku/data/buku_get_one.dart';
import '../../../api/buku/model/model_buku.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/app_textfield.dart';
import '../../../shared/widget/show_snackbar.dart';
import '../../../sql/sql_constants.dart';
import '../../../sql/sql_helper.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import '../../../utils/get_tokens.dart';
import '../widgets/read_menu.dart';

class ReadController extends GetxController {
  PdfViewerController pdfController = PdfViewerController();
  PdfTextSearchResult searchResult = PdfTextSearchResult();

  final searchController = TextEditingController();
  final searchPageController = TextEditingController();
  final searchFocusNode = FocusNode();
  final searchPageFocusNode = FocusNode();

  Rx<int> currentPage = 1.obs;
  Rx<bool> isFullScreen = false.obs;
  Rx<bool> isOnSearch = false.obs;
  Rx<bool> noResultFound = false.obs;

  Rx<Tokens?> tokens = Rx<Tokens?>(null);
  Rx<ModelBuku?> buku = Rx<ModelBuku?>(null);

  @override
  Future<void> onInit() async {
    final String? args = Get.arguments;
    tokens.value = await getTokens();
    final response = await getOneBuku(args ?? "");
    final a = await SQLHelper().read(SQLParam(table: SQLConstants().table.buku));
    print(a.toString());
    if (response.data != null) {
      buku.value = response.data;
    } else {
      showSnackbar(message: "Terjadi kesalahan", backgroundColor: AppColor.red);
    }
    super.onInit();
  }

  void onPageChanged(int page) {
    currentPage.value = page;
  }

  void showMenu() {
    Get.bottomSheet(
      const ReadMenu(),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.r)),
      ),
      isScrollControlled: true,
      enableDrag: false,
    );
  }

  void showPageSearchDiaog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColor.white,
        surfaceTintColor: AppColor.white,
        title: const Text("Masukan halaman buku"),
        content: AppTextField(
          type: TextFieldType.normal,
          controller: searchPageController,
          focusNode: searchPageFocusNode,
          keyboardType: TextInputType.number,
          isError: false,
          onChanged: (text) {
            if (text.isNotEmpty) {
              if (int.parse(text) > pdfController.pageCount) {
                searchPageController.text = pdfController.pageCount.toString();
              }
            }
          },
          label: Text(
            "Halaman",
            style: AppTextStyle.ts14Reg.copyWith(color: AppColor.grey),
          ),
        ),
        actions: [
          AppButton(
            type: ButtonType.text,
            onPressed: Get.back,
            child: const Text("Batal"),
          ),
          AppButton(
            type: ButtonType.elevated,
            padding: const EdgeInsets.symmetric(vertical: Sizes.xs, horizontal: Sizes.m),
            onPressed: () {
              final pageNumber = int.parse(searchPageController.text);
              pdfController.jumpToPage(pageNumber);
              Get.back();
            },
            child: const Text("Cari"),
          ),
        ],
      ),
      transitionDuration: const Duration(milliseconds: 100),
    );
  }
}
