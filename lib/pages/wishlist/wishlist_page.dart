import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

import '../../api/buku-perpustakaan/model/model_all_buku_perpustakaan.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../routes/app_routes.dart';
import '../../shared/widget/app_textfield.dart';
import '../../shared/widget/book_card.dart';
import '../../shared/widget/book_card_skeleton.dart';
import '../../shared/widget/empty_list.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/compute_luminance.dart';
import 'controller/wishlist_controller.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WishlistController>();
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            HGap.s,
            Expanded(
              child: Text(
                "Perpustakaan Orbit",
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.ts18Bold,
              ),
            ),
          ],
        ),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.m),
        child: Column(
          children: [
            VGap.m,
            AppTextField(
              type: TextFieldType.rounded,
              controller: controller.textController,
              focusNode: controller.focusNode,
              onTapOutside: (_) => controller.focusNode.unfocus(),
              onChanged: controller.onSearch,
              isError: false,
              contentPadding: const EdgeInsets.symmetric(vertical: Sizes.s, horizontal: Sizes.r),
              suffix: GestureDetector(
                onTap: () {
                  controller.onSearch("");
                  controller.textController.clear();
                },
                child: const Icon(Icons.close_rounded),
              ),
              label: Text(
                "Pencarian...",
                style: AppTextStyle.ts18Reg.copyWith(color: AppColor.grey),
              ),
            ),
            VGap.r,
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => await controller.onInit(),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: Sizes.m),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: GetBuilder<WishlistController>(
                    builder: (WishlistController c) {
                      final filteredWishlist = c.filteredWishlist.value;
                      final _ = c.asc.value; // Untuk trigger re-render
                      if (filteredWishlist == null) {
                        return AlignedGridView.count(
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
                      if (c.wishlist.value?.isEmpty ?? true) {
                        return const Column(
                          children: [
                            VGap.m,
                            EmptyList(
                              description: "Anda belum mempunyai wishlist buku",
                            ),
                          ],
                        );
                      }
                      if (filteredWishlist.isEmpty) {
                        return const Column(
                          children: [
                            VGap.m,
                            EmptyList(
                              description: "Buku yang Anda cari tidak ada",
                            ),
                          ],
                        );
                      }
                      return AlignedGridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        itemCount: filteredWishlist.length,
                        mainAxisSpacing: Sizes.r,
                        crossAxisSpacing: Sizes.r,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final payload = filteredWishlist[index].bukuPerpustakaan;
                          final buku = payload?.buku;
                          return BookCard(
                            bukuPerpustakaan: payload!,
                            id: buku?.id ?? "-",
                            judul: buku?.judul ?? "-",
                            penulis: buku?.penulis ?? "-",
                            idSampul: buku?.assetSampulId ?? "-",
                            copy: "${payload.jumlahSiapPinjam ?? '-'}",
                            harga: (int.parse(buku?.hargaSewa ?? "0") ~/ 100).toString(),
                            onTap: () => Get.toNamed(AppRoutes.book, arguments: Payload.fromJson(payload.toJson())),
                            onChangeWishlist: () {},
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

var a = {
  "name": "koleksi-buku.getAll | Get All Koleksi Buku For Validated User",
  "type": "Success",
  "statusCode": 200,
  "result": {
    "totalAllData": 2,
    "totalData": 2,
    "limit": 10,
    "totalPage": 1,
    "currentPage": 1,
    "lastPage": 1,
    "nextPage": null,
    "previousPage": null,
    "payload": [
      {
        "id": "5fa3c640-44c3-48cd-97bb-3c6a4381af89",
        "createdAt": "2024-01-18T06:04:45.069Z",
        "updatedAt": "2024-01-18T06:04:45.069Z",
        "tipe": "Pinjam",
        "harga": 0,
        "waktuHabis": "2024-01-25T06:04:45.069Z",
        "buku": {
          "id": "aa3aa79a-bdfe-4571-af36-4eccba92f00d",
          "createdAt": "2024-01-05T03:58:55.190Z",
          "updatedAt": "2024-01-05T03:58:55.190Z",
          "judul": "Filosofi Teras",
          "sinopsis":
              "Lebih dari 2.000 tahun lalu, sebuah mazhab filsafat menemukan akar masalah dan juga solusi dari banyak emosi negatif. Stoisisme, atau Filosofi Teras, adalah filsafat Yunani-Romawi kuno yang bisa membantu kita mengatasi emosi negatif dan menghasilkan mental yang tangguh dalam menghadapi naik-turunnya kehidupan. Jauh dari kesan filsafat sebagai topik berat dan mengawang-awang, Filosofi Teras justru bersifat praktis dan relevan dengan kehidupan Generasi Milenial dan Gen-Z masa kini.",
          "jumlahHalaman": 346,
          "tahunTerbit": "2018",
          "isbn": "isbn",
          "eIsbn": "eIsbn",
          "bahasa": "Indonesia",
          "ilustrator": "Siapa yak ?",
          "penulis": "Henry Manampiring",
          "hargaBeli": "80000",
          "hargaSewa": "10000",
          "assetSampulId": "5f43719c-83cd-4635-ab06-f414d3654e45",
          "assetBukuId": "a73fbe77-8abe-4213-8041-46df36d6cada",
          "katalog": {
            "id": "b7f57eee-580a-4069-9af9-eecac1ea1218",
            "createdAt": "2024-01-02T08:34:20.375Z",
            "updatedAt": "2024-01-02T08:34:20.375Z",
            "nama": "Psikologi"
          },
          "penerbit": {
            "id": "f872b8aa-7852-4b7d-aea5-bb24847f3cdb",
            "createdAt": "2024-01-05T03:36:20.455Z",
            "updatedAt": "2024-01-05T03:36:20.455Z",
            "nama": "Gramedia Solo",
            "kode": "gramed",
            "noTelepon": "089123781294",
            "deskripsi": null,
            "tahunBerdiri": "1996"
          },
          "promo": null
        }
      },
      {
        "id": "641000e7-c269-4794-8804-26e144b13a94",
        "createdAt": "2024-01-18T05:21:14.150Z",
        "updatedAt": "2024-01-18T05:21:14.150Z",
        "tipe": "Pinjam",
        "harga": 0,
        "waktuHabis": "2024-01-25T05:21:14.152Z",
        "buku": {
          "id": "85706ed0-7f79-4edb-84a2-cd6a5e77b735",
          "createdAt": "2024-01-05T04:09:21.992Z",
          "updatedAt": "2024-01-05T04:09:21.992Z",
          "judul": "Metodologi Studi Islam",
          "sinopsis":
              "Keyakinan agama Islam yang dibawa oleh Nabi Muhammad SAW diyakini menjamin terwujudnya kehidupan manusia yang sejahtera lahir dan batin. Ajaran Islam menunjukkan gambaran yang ideal tentang bagaimana seharusnya manusia menyikapi hidup dan kehidupan ini secara lebih bermakna. Kenyataan bahwa Islam kini menampilkan realitas yang lebih ideal, disebabkan karena pemahaman keagamaan umat yang masih rendah atau keliru dalam mendalami Islam. Buku ini diharapkan dapat memberikan pengetahuan kepada kita untuk memahami Islam dengan pendekatan yang komprehensif melalui penerapan metode dan teknik studi Islam yang aplikatif.\n\nIslam tidak akan dapat dipahami dengan universal dan humanis tanpa mendekatinya dengan pendekatan sosiologis. Beberapa gejala dalam masyarakat kaum muslimin, selain juga bisa didekati dengan beberapa pendekatan lain, tentu menyediakan ruang untuk dikaji dengan pendekatan sosiologis. Karena banyak bidang kajian agama yang baru dapat dipahami secara proporsional dan tepat apabila menggunakan jasa bantuan sosiologi, di sini letaknya sosiologi sebagai salah satu instrumen dalam memahami ajaran agama. Kajian tentang Islam bukan hanya dilakukan oleh orang-orang Islam, namun juga dilakukan oleh orang-orang di luar Islam. Di Barat, kajian Islam dikenal dengan istilah Islamic Studies, secara mendalam dapat dikatakan sebagai usaha untuk mempelajari hal-hal yang berhubungan dengan agama Islam. Kajian Metodologi Studi Islam merupakan kajian keislaman yang didekatkan pada pendekatan-pendekatan berbagai disiplin keilmuan. Kekuatan berbagai pendekatan ilmunya akan menjadikan kajian Keislaman memiliki warna warni dari semua sudut pandang. Hal inilah yang membuat Metodologi Studi Islam ini menjadi penting untuk dipelajari di tingkat Perguruan Tinggi.",
          "jumlahHalaman": 494,
          "tahunTerbit": "2008",
          "isbn": "9789794217061",
          "eIsbn": "eIsbn",
          "bahasa": "Indonesia",
          "ilustrator": "Lupa juga",
          "penulis": "Abuddin Nata",
          "hargaBeli": "120000",
          "hargaSewa": "12000",
          "assetSampulId": "0b3187cc-69ed-4e93-8ff6-16c5613682d4",
          "assetBukuId": "28d7a654-6fb4-4c2f-a9b2-bc82584bee31",
          "katalog": {
            "id": "161267b3-71aa-4167-85c2-2b2076c3f240",
            "createdAt": "2024-01-02T08:08:09.381Z",
            "updatedAt": "2024-01-02T08:08:09.381Z",
            "nama": "Pendidikan"
          },
          "penerbit": {
            "id": "f872b8aa-7852-4b7d-aea5-bb24847f3cdb",
            "createdAt": "2024-01-05T03:36:20.455Z",
            "updatedAt": "2024-01-05T03:36:20.455Z",
            "nama": "Gramedia Solo",
            "kode": "gramed",
            "noTelepon": "089123781294",
            "deskripsi": null,
            "tahunBerdiri": "1996"
          },
          "promo": null
        }
      }
    ]
  }
};
