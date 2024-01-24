import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../api/kategori-perpus/model/model_kategori_perpus_all.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../shared/widget/book_card_skeleton.dart';
import 'controller/books_controller.dart';
import 'widgets/books_category_container.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BooksController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Semua Buku"),
        // actions: [
        //   // IconButton(
        //   //   onPressed: controller.showFilter,
        //   //   icon: SvgPicture.asset("assets/icons/filter.svg"),
        //   // ),
        //   // HGap.r,
        // ],
      ),
      body: RefreshIndicator(
        onRefresh: controller.onInit,
        child: Obx(() {
          final filters = controller.filters;
          final categories = controller.categories.value;
          if (categories == null) {
            return AlignedGridView.count(
              padding: const EdgeInsets.all(Sizes.m),
              shrinkWrap: true,
              crossAxisCount: 2,
              itemCount: 10,
              mainAxisSpacing: Sizes.r,
              crossAxisSpacing: Sizes.r,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return const BookCardSkeleton();
              },
            );
          }
          final filteredCategories = categories.where((category) {
            return filters.contains(category.nama);
          }).toList();
          final datas = filteredCategories.isEmpty ? categories : filteredCategories;
          return ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: Sizes.s, bottom: Sizes.m),
            itemCount: datas.length + 1,
            itemBuilder: (ctx, idx) {
              log(datas.length.toString());
              log(idx.toString());
              if (idx == datas.length) {
                return BooksCategoryContainer(
                  category: KategoriBukuPerpustakaan(nama: "Lainnya", id: "Lainnya"),
                );
              }
              return BooksCategoryContainer(category: datas[idx]);
            },
          );
        }),
      ),
    );
  }
}
