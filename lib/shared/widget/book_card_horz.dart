import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../api/api_path.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';

class BookCardHorz extends StatelessWidget {
  const BookCardHorz({
    super.key,
    required this.id,
    required this.idSampul,
    required this.judul,
    required this.penulis,
    required this.harga,
    this.copy,
    required this.onTap,
  });

  final String id;
  final String idSampul;
  final String judul;
  final String penulis;
  final String harga;
  final String? copy;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
          color: Colors.white,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(
                APIPath.publicAsset(idSampul),
                fit: BoxFit.cover,
                width: 75,
              ),
            ),
            HGap.s,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(Sizes.s),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      judul,
                      style: AppTextStyle.ts14Bold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    VGap.s,
                    Text(
                      penulis,
                      style: AppTextStyle.ts14Light,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    VGap.s,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Tersedia: $copy Buku",
                          style: AppTextStyle.ts10Reg.copyWith(color: AppColor.grey),
                        ),
                        HGap.s,
                        SvgPicture.asset(
                          "assets/icons/coin.svg",
                          width: Sizes.sr,
                          colorFilter: ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
                        ),
                        Text(
                          harga,
                          style: AppTextStyle.ts10Bold.copyWith(color: theme.primaryColor),
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
