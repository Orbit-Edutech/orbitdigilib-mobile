import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../api/api_path.dart';
import '../../../api/transaksi-fisik/model/model_transaksi_fisik.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class TransaksiFisikCard extends StatelessWidget {
  const TransaksiFisikCard({super.key, required this.item});
  final TransaksiFisikItem item;

  @override
  Widget build(BuildContext context) {
    final buku = item.bukuFisik;
    final Color statusColor;
    final String statusLabel;
    if (item.isDipinjam && item.isOverdue) {
      statusColor = AppColor.red;
      statusLabel = "Terlambat";
    } else if (item.isDipinjam && item.isAlmostDue) {
      statusColor = AppColor.orange;
      statusLabel = "Jatuh Tempo";
    } else if (item.isDipinjam) {
      statusColor = AppColor.primary;
      statusLabel = "Dipinjam";
    } else {
      statusColor = AppColor.grey;
      statusLabel = "Dikembalikan";
    }

    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: Sizes.r),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Row(
        children: [
          Container(
            width: 75,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: const BoxDecoration(color: AppColor.lightGrey),
            child: buku?.assetSampul?.id == null
                ? const Center(child: Icon(Icons.book, color: AppColor.grey, size: 30))
                : Image(
                    image: CachedNetworkImageProvider(APIPath.publicAsset(buku!.assetSampul!.id!)),
                    fit: BoxFit.cover,
                    width: 75,
                    height: 100,
                  ),
          ),
          HGap.s,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Sizes.s),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    buku?.judul ?? "-",
                    style: AppTextStyle.ts14Bold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    buku?.penulis ?? "-",
                    style: AppTextStyle.ts12Light.copyWith(color: AppColor.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: Sizes.s),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(Sizes.xh)),
                          color: statusColor.withOpacity(0.12),
                        ),
                        child: Text(statusLabel, style: AppTextStyle.ts10Bold.copyWith(color: statusColor)),
                      ),
                      HGap.xs,
                      if (item.tanggalKembali != null)
                        Text(
                          "Kembali: ${_fmtDate(item.tanggalKembali!)}",
                          style: AppTextStyle.ts10Reg.copyWith(
                            color: item.isOverdue ? AppColor.red : AppColor.grey,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _fmtDate(DateTime d) {
    final local = d.toLocal();
    return "${local.day.toString().padLeft(2, '0')}/${local.month.toString().padLeft(2, '0')}/${local.year}";
  }
}
