import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../api/api_path.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import '../../utils/compute_luminance.dart';

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
    required this.isPromo,
  });

  final String id;
  final String idSampul;
  final String judul;
  final String penulis;
  final String harga;
  final String? copy;
  final bool isPromo;
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
            Stack(
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
                if (isPromo)
                  Positioned(
                    left: -50,
                    child: Transform.rotate(
                      angle: -.8,
                      child: Container(
                        width: 100,
                        color: theme.primaryColor,
                        margin: const EdgeInsets.all(Sizes.sr),
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          "     Diskon",
                          style: AppTextStyle.ts10Bold.copyWith(
                            color: calculateLuminance(theme.primaryColor),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
              ],
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
                          " ${int.parse(harga) < 1 ? "Gratis" : 0}",
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
