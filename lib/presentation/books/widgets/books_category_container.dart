import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../api/api_path.dart';
import '../../../api/buku-perpustakaan/data/buku_perpustakaan_get_all.dart';
import '../../../api/buku-perpustakaan/model/model_all_buku_perpustakaan.dart';
import '../../../api/katalog-perpus/model/model_katalog_perpus_all.dart' as k;
import '../../../api/wishlist/model/model_wishlist_all.dart';
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

  final k.KatalogBukuPerpustakaan category;

  @override
  State<BooksCategoryContainer> createState() => _BooksCategoryContainerState();
}

class _BooksCategoryContainerState extends State<BooksCategoryContainer> {
  final controller = Get.find<BooksController>();
  List<Payload>? books;
  @override
  void initState() {
    Map<String, dynamic> qp = <String, dynamic>{};
    if (widget.category.nama == "Lainnya") {
      qp = {"katalogBukuPerpustakaanId": "null"};
    } else {
      qp = {"katalogBukuPerpustakaanId": widget.category.id};
    }
    getAllBukuPerpustakaan(qp).then((res) {
      if (res.data != null) {
        if (mounted) {
          setState(() {
            books = res.data!.payload?.where((book) => book.isVisible!).toList();
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
                    if (widget.category.icon?.id != null) ...[
                      Image.network(
                        APIPath.publicAsset(widget.category.icon!.id!),
                        color: theme.primaryColor,
                      ),
                    ] else ...[
                      Icon(Icons.more_vert, color: theme.primaryColor)
                    ],
                    HGap.s,
                    Expanded(
                      child: Text(
                        widget.category.nama ?? "Lainnya",
                        style: AppTextStyle.ts14Bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Get.toNamed(
                  AppRoutes.category,
                  arguments: widget.category.nama == "Lainnya"
                      ? k.KatalogBukuPerpustakaan(nama: "Lainnya", id: "null")
                      : widget.category,
                ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (books == null) ...[
                for (var _ in List.generate(10, (i) => i)) ...[
                  const BookCardSkeleton(),
                  HGap.r,
                ],
              ],
              if (books?.isEmpty ?? false) ...[
                EmptyList(
                  description: "Tidak ada buku di Katalog ${widget.category.nama ?? '-'}",
                )
              ],
              if (books != null && books!.isNotEmpty) ...[
                for (var payload in books!) ...[
                  BookCard(
                    bukuPerpustakaan: BukuPerpustakaan.fromJson(payload.toJson()),
                    id: payload.buku?.id ?? "-",
                    judul: payload.buku?.judul ?? "-",
                    penulis: payload.buku?.penulis ?? "-",
                    idSampul: payload.buku?.assetSampulId ?? "",
                    copy: "${payload.jumlahSiapPinjam ?? '-'}",
                    harga: ((payload.buku?.hargaSewa ?? 0) ~/ 100).toString(),
                    isPromo: payload.buku?.promo != null,
                    onTap: () => Get.toNamed(AppRoutes.book, arguments: payload),
                  ),
                  HGap.r,
                ],
              ]
            ],
          ),
        )
      ],
    );
  }
}
