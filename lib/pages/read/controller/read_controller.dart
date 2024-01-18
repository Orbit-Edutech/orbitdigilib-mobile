import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/route_manager.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../constants/sizes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/app_textfield.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
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
