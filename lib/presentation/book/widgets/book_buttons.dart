import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../../api/buku-perpustakaan/model/model_one_buku_perpustakaan.dart';
import '../../../constants/gaps.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/app_button.dart';
import '../controller/book_controller.dart';

class BookButtons extends StatelessWidget {
  const BookButtons({
    super.key,
    required this.book,
  });

  final Buku? book;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookController>();
    return Obx(() {
      final isInCollections = controller.isInCollections.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppButton(
            type: ButtonType.elevated,
            onPressed: isInCollections
                ? () => Get.toNamed(
                      AppRoutes.read,
                      arguments: {"asset": controller.book.value?.buku?.id, "type": "read"},
                    )
                : controller.showOptions,
            child: const Text("Baca Buku"),
          ),
          if (!isInCollections) ...[
            VGap.s,
            AppButton(
              type: ButtonType.outlined,
              onPressed: () => Get.toNamed(
                AppRoutes.read,
                arguments: {"asset": controller.book.value?.buku?.id, "type": "sample"},
              ),
              child: const Text("Sampel Buku"),
            ),
          ]
        ],
      );
    });
  }
}
