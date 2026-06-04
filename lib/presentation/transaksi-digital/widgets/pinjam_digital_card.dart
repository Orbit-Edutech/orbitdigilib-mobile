import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../api/api_path.dart';
import '../../../api/transaksi/model/model_pinjam.dart';
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';

class PinjamDigitalCard extends StatelessWidget {
  const PinjamDigitalCard({super.key, required this.item});
  final ModelPinjam item;

  @override
  Widget build(BuildContext context) {
    final buku = item.bukuPerpust?.buku;
    final tanggalKembali = item.tanggalKembali;
    final now = DateTime.now();

    final Color statusColor;
    final String statusLabel;
    if (tanggalKembali != null && now.isAfter(tanggalKembali)) {
      statusColor = AppColor.grey;
      statusLabel = "Berakhir";
    } else if (tanggalKembali != null && tanggalKembali.difference(now).inDays <= 3) {
      statusColor = AppColor.orange;
      statusLabel = "Jatuh Tempo";
    } else {
      statusColor = AppColor.primary;
      statusLabel = "Aktif";
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
            child: buku?.assetSampulId == null
                ? const Center(child: Icon(Icons.book, color: AppColor.grey, size: 30))
                : Image(
                    image: CachedNetworkImageProvider(APIPath.publicAsset(buku!.assetSampulId!)),
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
                      if (tanggalKembali != null)
                        Text(
                          "Kembali: ${_fmtDate(tanggalKembali)}",
                          style: AppTextStyle.ts10Reg.copyWith(color: AppColor.grey),
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
