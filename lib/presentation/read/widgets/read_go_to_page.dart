import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../constants/sizes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../shared/widget/app_textfield.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class ReadGoToPage extends StatelessWidget {
  const ReadGoToPage({
    super.key,
    required this.searchPageController,
    required this.searchPageFocusNode,
    required this.pdfController,
    required this.isSample,
    required this.sampleLimit,
    required this.onPageChanged,
  });

  final TextEditingController searchPageController;
  final FocusNode searchPageFocusNode;
  final PdfViewerController pdfController;
  final bool isSample;
  final int sampleLimit;
  final Function(int) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.white,
      surfaceTintColor: AppColor.white,
      title: const Text("Masukan halaman buku"),
      content: AppTextField(
        type: TextFieldType.normal,
        controller: searchPageController,
        focusNode: searchPageFocusNode,
        keyboardType: TextInputType.number,
        isError: false,
        autoFocus: true,
        onSubmitted: (text) {
          onPageChanged(int.parse(text));
          Get.back();
          pdfController.jumpToPage(int.parse(text));
        },
        onChanged: (text) {
          if (text.isNotEmpty) {
            try {
              if (isSample) {
                if (sampleLimit > pdfController.pageCount) {
                  searchPageController.text = pdfController.pageCount.toString();
                } else if (int.parse(text) > sampleLimit) {
                  searchPageController.text = "$sampleLimit";
                }
              } else if (int.parse(text) > pdfController.pageCount) {
                searchPageController.text = pdfController.pageCount.toString();
              }
            } catch (e) {
              searchPageController.clear();
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
    );
  }
}
