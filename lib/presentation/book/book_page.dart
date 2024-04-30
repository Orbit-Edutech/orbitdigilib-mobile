import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../api/buku-perpustakaan/model/model_all_buku_perpustakaan.dart';
import '../../api/wishlist/model/model_wishlist_all.dart';
import '../../constants/gaps.dart';
import '../../shared/widget/wishlist_button.dart';
import '../../utils/compute_luminance.dart';
import 'controller/book_controller.dart';
import 'widgets/book_background_blur.dart';
import 'widgets/book_cover.dart';
import 'widgets/book_metadata.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookController>();
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Buku"),
        centerTitle: true,
        actions: [
          WishlistButton(
            bukuPerpustakaan: BukuPerpustakaan.fromJson((controller.args ?? Payload()).toJson()),
            color: calculateLuminance(theme.primaryColor),
          ),
          HGap.s,
        ],
      ),
      body: Obx(() {
        final payload = controller.book.value;
        return Opacity(
          opacity: payload == null ? 0 : 1,
          child: Stack(
            children: [
              BookBackgroundBlur(book: payload?.buku),
              SizedBox(
                height: size.height,
                child: SingleChildScrollView(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  padding: const EdgeInsets.only(top: 150),
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      BookMetadata(book: payload?.buku),
                      BookCover(book: payload?.buku),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
