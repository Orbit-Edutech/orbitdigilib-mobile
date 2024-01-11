import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../routes/app_routes.dart';
import '../../shared/widget/app_textfield.dart';
import '../../shared/widget/book_card_horz.dart';
import '../../shared/widget/book_card_skeleton.dart';
import '../../shared/widget/empty_list.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/compute_luminance.dart';
import 'controller/search_page_controller.dart';

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
            onPressed: controller.sort,
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
              contentPadding: const EdgeInsets.symmetric(vertical: Sizes.s, horizontal: Sizes.r),
              label: Text(
                "Pencarian...",
                style: AppTextStyle.ts18Reg.copyWith(color: AppColor.lightGrey),
              ),
            ),
          ),
          VGap.s,
          Expanded(
            child: Obx(() {
              final books = controller.books.value;
              if (books == null) {
                return ListView.builder(
                  padding: const EdgeInsets.all(Sizes.m),
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (ctx, idx) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const BookCardSkeleton(),
                            HGap.m,
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 25,
                                    decoration: const BoxDecoration(
                                      color: AppColor.lightGrey,
                                      borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                                    ),
                                  ),
                                  VGap.s,
                                  Container(
                                    height: 25,
                                    decoration: const BoxDecoration(
                                      color: AppColor.lightGrey,
                                      borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                                    ),
                                  ),
                                  VGap.s,
                                  Container(
                                    height: 25,
                                    decoration: const BoxDecoration(
                                      color: AppColor.lightGrey,
                                      borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        VGap.s,
                      ],
                    );
                  },
                );
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
                        idSampul: book?.assetSampulId ?? "-",
                        copy: "${books[idx].jumlahSiapPinjam ?? '-'}",
                        harga: (int.parse(book?.hargaSewa ?? "0") ~/ 100).toString(),
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
