import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_path.dart';
import '../../../api/buku/data/buku_get_all.dart';
import '../../../api/buku/model/model_all_buku.dart';
import '../../../api/buku/model/model_categories_books.dart';
import '../../../api/kategori-perpus/model/model_kategori_perpus_all.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../routes/app_routes.dart';
import '../../../shared/widget/book_card.dart';
import '../../../shared/widget/book_card_skeleton.dart';
import '../../../shared/widget/empty_list.dart';
import '../../../theme/app_text_stlye.dart';
import '../controller/books_controller.dart';

class BooksCategoryContainer extends StatefulWidget {
  const BooksCategoryContainer({
    super.key,
    required this.category,
  });

  final KategoriBukuPerpustakaan category;

  @override
  State<BooksCategoryContainer> createState() => _BooksCategoryContainerState();
}

class _BooksCategoryContainerState extends State<BooksCategoryContainer> {
  final controller = Get.find<BooksController>();
  List<Payload>? books;
  @override
  void initState() {
    final categoryBooks = controller.datas.value.firstWhereOrNull((data) {
      return data.category.id == widget.category.id;
    });
    if (categoryBooks != null) {
      books = categoryBooks.books;
    } else {
      final qp = {"kategoriBukuPerpustakaanId": widget.category.id};
      getAllBuku(qp).then((res) {
        if (res.data != null) {
          if (mounted) {
            setState(() {
              controller.datas.value.add(CategoriesBooks(category: widget.category, books: res.data!.payload!));
              books = res.data!.payload;
            });
          }
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: Sizes.m,
            right: Sizes.m,
            top: Sizes.r,
            bottom: Sizes.s,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Image.network(APIPath.publicAsset(widget.category.icon?.id ?? "-")),
                    HGap.s,
                    Expanded(
                      child: Text(
                        widget.category.nama ?? "-",
                        style: AppTextStyle.ts14Bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.category, arguments: widget.category),
                child: Text(
                  "Lihat Semua",
                  style: AppTextStyle.ts10Light,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: Sizes.m, right: Sizes.s),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (books == null) ...[
                for (var _ in [1, 1, 1, 1, 1]) ...[
                  const BookCardSkeleton(),
                  HGap.r,
                ],
              ],
              if (books?.isEmpty ?? true) ...[
                EmptyList(
                  description: "Tidak ada buku di Kategori ${widget.category.nama ?? '-'}",
                )
              ],
              if (books != null && books!.isNotEmpty) ...[
                for (var book in books!) ...[
                  BookCard(
                    judul: book.buku?.judul ?? "-",
                    penulis: book.buku?.penulis ?? "-",
                    idSampul: book.buku?.assetSampulId ?? "",
                    harga: book.buku?.hargaSewa ?? "-",
                    copy: "${book.jumlahSoftCopy ?? '-'}",
                    isWishlist: true,
                    onTap: () {},
                    onChangeWishlist: () {},
                  ),
                ]
              ]
            ],
          ),
        )
      ],
    );
  }
}
