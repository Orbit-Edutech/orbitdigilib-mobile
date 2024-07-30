import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../sql/books/model/model_buku_sql.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import '../../../utils/is_today.dart';
import 'offline_read_dialog.dart';

class OfflineBookCard extends StatelessWidget {
  const OfflineBookCard({
    super.key,
    required this.book,
  });

  final ModelBukuSql book;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now().toUtc();
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
      ),
      margin: const EdgeInsets.only(bottom: Sizes.r),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
        onTap: () {
          Get.bottomSheet(
            OfflineReadDialog(
              buku: book,
              lastPageSeen: book.lastPageSeen,
              totalPages: book.totalPages,
            ),
            enableDrag: false,
            isScrollControlled: true,
          );
        },
        child: Row(
          children: [
            Container(
              width: 75,
              alignment: Alignment.bottomLeft,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(Sizes.s),
                    child: const Text(
                      "Sampul Kosong",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (isToday(book.expired) ?? false)
                    Container(
                      width: 75,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: Sizes.xs),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.string(
                            """
                            <svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg">
                            <g id="alarm">
                            <mask id="mask0_735_461" style="mask-type:alpha" maskUnits="userSpaceOnUse" x="0" y="0" width="13" height="12">
                            <rect id="Bounding box" x="0.000976562" width="12" height="12" fill="#D9D9D9"/>
                            </mask>
                            <g mask="url(#mask0_735_461)">
                            <path id="alarm_2" d="M6.00078 11C5.37578 11 4.79037 10.8813 4.24453 10.6438C3.6987 10.4063 3.2237 10.0855 2.81953 9.6813C2.41536 9.27713 2.09453 8.80213 1.85703 8.2563C1.61953 7.71047 1.50078 7.12505 1.50078 6.50005C1.50078 5.87505 1.61953 5.28963 1.85703 4.7438C2.09453 4.19797 2.41536 3.72297 2.81953 3.3188C3.2237 2.91463 3.6987 2.5938 4.24453 2.3563C4.79037 2.1188 5.37578 2.00005 6.00078 2.00005C6.62578 2.00005 7.2112 2.1188 7.75703 2.3563C8.30287 2.5938 8.77786 2.91463 9.18203 3.3188C9.5862 3.72297 9.90703 4.19797 10.1445 4.7438C10.382 5.28963 10.5008 5.87505 10.5008 6.50005C10.5008 7.12505 10.382 7.71047 10.1445 8.2563C9.90703 8.80213 9.5862 9.27713 9.18203 9.6813C8.77786 10.0855 8.30287 10.4063 7.75703 10.6438C7.2112 10.8813 6.62578 11 6.00078 11ZM7.40078 8.60005L8.10078 7.90005L6.50078 6.30005V4.00005H5.50078V6.70005L7.40078 8.60005ZM2.80078 1.17505L3.50078 1.87505L1.37578 4.00005L0.675781 3.30005L2.80078 1.17505ZM9.20078 1.17505L11.3258 3.30005L10.6258 4.00005L8.50078 1.87505L9.20078 1.17505Z" fill="#${AppColor.red.value.toRadixString(16).substring(2)}"/>
                            </g>
                            </g>
                            </svg>
                          """,
                            width: 12,
                          ),
                          HGap.xs,
                          Text(
                            "${(book.expired.hour - now.hour).isNegative ? 0 : book.expired.hour - now.hour}j ${(book.expired.hour - now.hour).isNegative ? 0 : book.expired.minute - now.minute}m",
                            style: AppTextStyle.ts10Reg,
                          )
                        ],
                      ),
                    ),
                ],
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
                      book.judul,
                      style: AppTextStyle.ts14Bold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      book.penulis,
                      style: AppTextStyle.ts14Light,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: Sizes.xs,
                            horizontal: Sizes.s,
                          ),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.xh),
                            ),
                            color: Colors.white,
                          ),
                          child: Text(
                            book.status,
                            style: AppTextStyle.ts10Bold.copyWith(
                              color: book.status == "Belum Dibaca"
                                  ? AppColor.red
                                  : book.status == "Belum Selesai"
                                      ? Colors.amber
                                      : Colors.green,
                            ),
                          ),
                        ),
                        HGap.xs,
                        Text(
                          "Hal - ${book.lastPageSeen} / ${book.totalPages}",
                          style: AppTextStyle.ts10Light.copyWith(color: AppColor.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
