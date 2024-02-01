import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';

import '../../../api/katalog-perpus/model/model_katalog_perpus_all.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../theme/app_text_stlye.dart';
import '../controller/books_controller.dart';
import 'books_category_card.dart';

class BooksCategoryFilter extends StatefulWidget {
  const BooksCategoryFilter({super.key});

  @override
  State<BooksCategoryFilter> createState() => _BooksCategoryFilterState();
}

class _BooksCategoryFilterState extends State<BooksCategoryFilter> {
  final controller = Get.find<BooksController>();
  List<KatalogBukuPerpustakaan> tempFilter = [];
  List<KatalogBukuPerpustakaan> categories = [];
  void filter(KatalogBukuPerpustakaan filter) {
    setState(() {
      tempFilter.contains(filter) ? tempFilter.remove(filter) : tempFilter.add(filter);
    });
  }

  @override
  void initState() {
    tempFilter.addAll(controller.filteredCategories.value!);
    categories = controller.categories.value!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.75,
      width: size.width,
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(Sizes.m),
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Sizes.l),
            topRight: Radius.circular(Sizes.l),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Kategori Buku",
                    style: AppTextStyle.ts14Bold,
                    textAlign: TextAlign.start,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      tempFilter.clear();
                    });
                  },
                  child: Text(
                    "Hapus",
                    style: AppTextStyle.ts12Bold.copyWith(color: theme.primaryColor),
                  ),
                )
              ],
            ),
            VGap.r,
            Expanded(
              child: AlignedGridView.count(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                crossAxisCount: 4,
                crossAxisSpacing: 0,
                mainAxisSpacing: Sizes.xs,
                itemCount: categories.length,
                itemBuilder: ((ctx, idx) {
                  final kategori = categories[idx];
                  return BooksCategoryCard(
                    category: kategori,
                    filter: filter,
                    categories: tempFilter,
                  );
                }),
              ),
            ),
            VGap.r,
            AppButton(
              type: ButtonType.elevated,
              onPressed: () async {
                Get.back();
                controller.filteredCategories.value = null;
                await Future.delayed(const Duration(milliseconds: 10));
                controller.filteredCategories.value = tempFilter;
              },
              child: Text("Terapkan", style: AppTextStyle.ts14Bold),
            ),
            VGap.s,
            AppButton(
              type: ButtonType.outlined,
              onPressed: Get.back,
              child: Text("Tutup", style: AppTextStyle.ts14Bold),
            ),
          ],
        ),
      ),
    );
  }
}
