import "package:flutter/material.dart";
import "package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart";
import "package:get/instance_manager.dart";
import "package:get/route_manager.dart";

// import "../../../api/buku/model/model_all_buku.dart";
import "../../../api/wishlist/model/model_wishlist_all.dart";
import "../../../constants/gaps.dart";
import "../../../constants/sizes.dart";
import "../../../routes/app_routes.dart";
import "../../../shared/widget/book_card.dart";
import "../../../theme/app_text_stlye.dart";
import "../controller/index_controller.dart";

class IndexRecommendation extends StatelessWidget {
  const IndexRecommendation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() {
      final controller = Get.find<IndexController>();
      final payloads = controller.pinnedBooks.value?.toList();
      if (payloads?.isEmpty ?? true) return const SizedBox();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VGap.m,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rekomendasi Buku",
                  style: AppTextStyle.ts14Bold,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.recommendation, arguments: payloads),
                  child: Text(
                    "Lihat Semua",
                    style: AppTextStyle.ts12Reg.copyWith(color: theme.primaryColor),
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(Sizes.m),
            child: Row(
              children: [
                for (var payload in payloads!) ...[
                  BookCard(
                    bukuPerpustakaan: BukuPerpustakaan.fromJson(payload.toJson()),
                    id: payload.buku?.id ?? "-",
                    judul: payload.buku?.judul ?? '-',
                    penulis: payload.buku?.penulis ?? '-',
                    idSampul: payload.buku?.assetSampulId ?? '-',
                    copy: "${payload.jumlahSiapPinjam ?? '-'}",
                    harga: (int.parse(payload.buku?.hargaSewa ?? "0") ~/ 100).toString(),
                    onTap: () => Get.toNamed(AppRoutes.book, arguments: payload),
                    onChangeWishlist: () {},
                  ),
                  HGap.r
                ],
              ],
            ),
          ),
          const Row(), // Kalau bukunya kosong dia tetep nge strech, biar title nya tetep di kiri
        ],
      );
    });
  }
}
