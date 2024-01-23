import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../api/api_path.dart';
import '../../api/perpustakaan/model/model_perpustakaan.dart' as p;
import '../../api/wishlist/model/model_wishlist_all.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../routes/app_routes.dart';
import '../../shared/widget/book_card.dart';
import '../../shared/widget/empty_list.dart';
import '../../theme/app_text_stlye.dart';
import '../index/controller/index_controller.dart';

class HighlightPage extends StatelessWidget {
  const HighlightPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<IndexController>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sorotan"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
        child: Obx(() {
          final banners = controller.perpustakaan.value?.banner;
          final promoBooks = controller.promoBooks.value;
          return ListView(
            controller: controller.scrollController,
            children: [
              VGap.m,
              for (p.Banner banner in banners ?? []) ...[
                InkWell(
                  onTap: () => controller.showLargeBanner(banner.id!),
                  borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
                  child: Container(
                    height: 150,
                    width: size.width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(APIPath.publicAsset(banner.id ?? "")),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
                    ),
                  ),
                ),
                VGap.r,
              ],
              VGap.r,
              Text(
                "Buku yang sedang promo",
                style: AppTextStyle.ts14Bold,
              ),
              VGap.r,
              if (promoBooks?.isNotEmpty ?? false) ...[
                AlignedGridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  itemCount: promoBooks?.length,
                  mainAxisSpacing: Sizes.r,
                  crossAxisSpacing: Sizes.r,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final payload = promoBooks![index];
                    final book = payload.buku;
                    return BookCard(
                      bukuPerpustakaan: BukuPerpustakaan.fromJson(payload.toJson()),
                      id: book?.id ?? "-",
                      judul: book?.judul ?? "-",
                      penulis: book?.penulis ?? "-",
                      idSampul: book?.assetSampulId ?? "-",
                      copy: "${payload.jumlahSiapPinjam ?? '-'}",
                      harga: (int.parse(book?.hargaSewa ?? "0") ~/ 100).toString(),
                      onTap: () => Get.toNamed(AppRoutes.book, arguments: payload),
                      onChangeWishlist: () {},
                    );
                  },
                ),
              ] else ...[
                const EmptyList(description: "Tidak ada buku yang sedang promo")
              ],
              VGap.m,
            ],
          );
        }),
      ),
    );
  }
}
