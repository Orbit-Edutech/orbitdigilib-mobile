import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../routes/app_routes.dart';
import '../../shared/widget/app_textfield.dart';
import '../../shared/widget/book_card_horz.dart';
import '../../shared/widget/empty_list.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/compute_luminance.dart';
import 'controller/search_page_controller.dart';
import 'widgets/search_loading_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<SearchPageController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Pencarian"),
        actions: [
          IconButton(
            onPressed: controller.sortBooks,
            icon: Icon(
              Icons.swap_vert_rounded,
              color: calculateLuminance(theme.primaryColor),
            ),
          ),
          HGap.s,
        ],
      ),
      body: Column(
        children: [
          VGap.m,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
            child: AppTextField(
              type: TextFieldType.rounded,
              controller: controller.textController,
              focusNode: controller.searchFocusNode,
              onTapOutside: (_) => controller.searchFocusNode.unfocus(),
              onChanged: controller.search,
              isError: false,
              autoFocus: true,
              contentPadding: const EdgeInsets.symmetric(vertical: Sizes.s, horizontal: Sizes.r),
              label: Text(
                "Pencarian...",
                style: AppTextStyle.ts18Reg.copyWith(color: AppColor.lightGrey),
              ),
            ),
          ),
          VGap.s,
          Expanded(
            child: GetBuilder<SearchPageController>(builder: (c) {
              final _ = controller.isReversed.value;
              final books = controller.books.value;
              if (books == null) {
                return const SearchLoadingWidget();
              }
              if (books.isEmpty) {
                return const Column(
                  children: [
                    VGap.m,
                    EmptyList(
                      description: "Buku yang Anda cari tidak ada",
                    ),
                  ],
                );
              }
              return ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.all(Sizes.m),
                shrinkWrap: true,
                itemCount: books.length,
                itemBuilder: (ctx, idx) {
                  final book = books[idx].buku;
                  return Column(
                    children: [
                      BookCardHorz(
                        id: book?.id ?? "-",
                        judul: book?.judul ?? "-",
                        penulis: book?.penulis ?? "-",
                        idSampul: book?.assetSampulId,
                        copy: "${books[idx].jumlahSiapPinjam ?? '-'}",
                        harga: ((book?.hargaSewa ?? 0) ~/ 100).toString(),
                        isPromo: book?.promo != null,
                        onTap: () => Get.toNamed(AppRoutes.book, arguments: books[idx]),
                      ),
                      VGap.s,
                    ],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
