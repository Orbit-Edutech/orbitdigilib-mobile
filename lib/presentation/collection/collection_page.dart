import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../api/koleksi/model/model_koleksi.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../shared/widget/app_textfield.dart';
import '../../shared/widget/book_card_skeleton.dart';
import '../../shared/widget/empty_list.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/compute_luminance.dart';
import 'controller/collection_controller.dart';
import 'widgets/collection_book_card.dart';
import 'widgets/collection_filter.dart';

class CollectionPage extends StatelessWidget {
  const CollectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CollectionController>();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Koleksi Saya"),
        actions: [
          IconButton(
            onPressed: controller.onSearch,
            icon: Icon(
              Icons.search,
              color: calculateLuminance(theme.primaryColor),
            ),
          ),
          HGap.sr,
        ],
      ),
      body: Column(
        children: [
          VGap.r,
          const CollectionFilter(),
          Obx(() {
            return Column(
              children: [
                if (controller.isOnSearch.value) ...[
                  VGap.r,
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
                      suffix: IconButton(
                        onPressed: () {
                          if (controller.textController.text.isNotEmpty) controller.search("");
                          controller.textController.clear();
                        },
                        icon: const Icon(Icons.close_rounded),
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: Sizes.s, horizontal: Sizes.r),
                      label: Text(
                        "Pencarian...",
                        style: AppTextStyle.ts18Reg.copyWith(color: AppColor.lightGrey),
                      ),
                    ),
                  ),
                  VGap.s,
                ],
              ],
            );
          }),
          VGap.s,
          Expanded(
            child: RefreshIndicator(
              onRefresh: controller.onInit,
              child: Obx(() {
                final filter = controller.filter.value;
                final books = getBooks(controller, filter);
                final _ = controller.page.value;
                final localBooks = controller.localBooks.value;
                if (books == null || localBooks == null) {
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
                  return const SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        VGap.m,
                        EmptyList(
                          description:
                              "Ups... Belum ada buku pada halaman ini\nSegera perbanyak koleksi untuk wawasan lebih luas",
                          textAlign: TextAlign.center,
                        ),
                        VGap.xh,
                        VGap.xh,
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: controller.scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: Sizes.m, vertical: Sizes.r),
                  shrinkWrap: true,
                  itemCount: books.length,
                  itemBuilder: (ctx, idx) {
                    final payload = books[idx];
                    final lb = localBooks.firstWhereOrNull((lb) => lb.idBuku == payload.bukuAnggota?.id);
                    return CollectionBookCard(
                      status: lb?.status ?? "-",
                      lastPageSeen: lb?.lastPageSeen ?? 0,
                      totalPage: lb?.totalPages ?? 0,
                      payload: payload,
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  List<Payload>? getBooks(CollectionController controller, String filter) {
    switch (filter) {
      case "Pinjam":
        return controller.collections.value?.where((payload) => payload.tipe == "Pinjam").toList();
      case "Sewa":
        return controller.collections.value?.where((payload) => payload.tipe == "Sewa").toList();
      case "Beli":
        return controller.collections.value?.where((payload) => payload.tipe == "Beli").toList();
      default:
        return controller.collections.value;
    }
  }
}
