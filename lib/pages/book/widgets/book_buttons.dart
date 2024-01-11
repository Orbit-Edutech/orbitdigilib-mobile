import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

import '../../../api/buku-perpustakaan/model/model_one_buku_perpustakaan.dart';
import '../../../constants/gaps.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          type: ButtonType.elevated,
          onPressed: controller.showOptions,
          child: const Text("Baca Buku"),
        ),
        VGap.s,
        AppButton(
          type: ButtonType.outlined,
          onPressed: () {},
          child: const Text("Sampel Buku"),
        ),
      ],
    );
  }
}
