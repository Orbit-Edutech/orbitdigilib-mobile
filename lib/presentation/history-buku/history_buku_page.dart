import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../api/api_path.dart';
import '../../api/laporan-literasi/model/model_ringkasan_bacaan.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/responsive_helper.dart';
import 'controller/history_buku_controller.dart';

const _bulan = [
  'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
  'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
];

String _formatTanggal(DateTime date) {
  return "${date.day} ${_bulan[date.month - 1]} ${date.year}";
}

String _formatDurasi(int totalDetik) {
  final jam = totalDetik ~/ 3600;
  final menit = (totalDetik % 3600) ~/ 60;
  if (jam > 0) return "${jam}j ${menit}m";
  return "${menit}m";
}

class HistoryBukuPage extends StatelessWidget {
  const HistoryBukuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HistoryBukuController>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("History Buku"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: ResponsiveHelper.getMaxContentWidth(context),
          ),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            final ringkasan = controller.ringkasan.value;
            if (ringkasan == null) {
              return const Center(child: Text("Gagal memuat data"));
            }

            final daftarBuku = ringkasan.daftarBuku ?? [];

            return RefreshIndicator(
              onRefresh: controller.fetchData,
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // Summary Cards
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(
                        ResponsiveHelper.getHorizontalPadding(context),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: _SummaryCard(
                              value: "${ringkasan.totalBukuDibaca ?? 0}",
                              label: "Buku",
                              icon: Icons.menu_book_rounded,
                              color: theme.primaryColor,
                            ),
                          ),
                          HGap.s,
                          Expanded(
                            child: _SummaryCard(
                              value: "${ringkasan.totalHalamanDibaca ?? 0}",
                              label: "Halaman",
                              icon: Icons.description_outlined,
                              color: theme.primaryColor,
                            ),
                          ),
                          HGap.s,
                          Expanded(
                            child: _SummaryCard(
                              value: _formatDurasi(
                                  ringkasan.totalDurasiMembaca ?? 0),
                              label: "Durasi",
                              icon: Icons.timer_outlined,
                              color: theme.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Section title
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            ResponsiveHelper.getHorizontalPadding(context),
                        vertical: Sizes.s,
                      ),
                      child: Text(
                        "BUKU YANG DIBACA",
                        style: AppTextStyle.ts12Bold
                            .copyWith(color: AppColor.grey),
                      ),
                    ),
                  ),

                  // Empty state or book list
                  if (daftarBuku.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(Sizes.r),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.menu_book_rounded,
                                size: 64,
                                color: AppColor.grey.withValues(alpha: 0.5),
                              ),
                              VGap.r,
                              Text(
                                "Belum ada buku yang dibaca",
                                style: AppTextStyle.ts14Reg
                                    .copyWith(color: AppColor.grey),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        horizontal:
                            ResponsiveHelper.getHorizontalPadding(context),
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final buku = daftarBuku[index];
                            return _BookHistoryCard(
                              buku: buku,
                              primaryColor: theme.primaryColor,
                            );
                          },
                          childCount: daftarBuku.length,
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.sr,
        horizontal: Sizes.s,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.sr)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          VGap.xs,
          Text(
            value,
            style: AppTextStyle.ts20Bold.copyWith(color: color),
          ),
          Text(
            label,
            style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
          ),
        ],
      ),
    );
  }
}

class _BookHistoryCard extends StatelessWidget {
  const _BookHistoryCard({
    required this.buku,
    required this.primaryColor,
  });

  final BukuRingkasan buku;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    final persentase = buku.persentase ?? 0;
    final terakhirDibaca = buku.terakhirDibaca;

    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.sr),
      padding: const EdgeInsets.all(Sizes.sr),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book cover
          Container(
            width: 60,
            height: 80,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(Sizes.xs)),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: buku.assetSampulId == null
                ? Container(
                    color: AppColor.lightGrey,
                    alignment: Alignment.center,
                    child: const Icon(Icons.menu_book, color: AppColor.grey),
                  )
                : Image(
                    image: CachedNetworkImageProvider(
                      APIPath.publicAsset(buku.assetSampulId!),
                    ),
                    fit: BoxFit.cover,
                    width: 60,
                    height: 80,
                  ),
          ),
          HGap.sr,
          // Book info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  buku.judul ?? "-",
                  style: AppTextStyle.ts14Bold,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                VGap.xs,
                Text(
                  buku.penulis ?? "-",
                  style: AppTextStyle.ts12Reg.copyWith(color: AppColor.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                VGap.s,
                // Progress bar
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(Sizes.xs)),
                        child: LinearProgressIndicator(
                          value: persentase / 100,
                          backgroundColor: AppColor.lightGrey,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(primaryColor),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    HGap.s,
                    Text(
                      "$persentase%",
                      style: AppTextStyle.ts12Bold.copyWith(color: primaryColor),
                    ),
                  ],
                ),
                VGap.xs,
                // Stats row
                Row(
                  children: [
                    Text(
                      "${buku.halamanDibaca ?? 0}/${buku.totalHalaman ?? 0} hal",
                      style:
                          AppTextStyle.ts10Reg.copyWith(color: AppColor.grey),
                    ),
                    const Spacer(),
                    if (terakhirDibaca != null)
                      Text(
                        "Terakhir: ${_formatTanggal(terakhirDibaca)}",
                        style: AppTextStyle.ts10Reg
                            .copyWith(color: AppColor.grey),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
