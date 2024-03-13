import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../api/api_path.dart';
import '../../api/wishlist/model/model_wishlist_all.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';
import 'wishlist_button.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.bukuPerpustakaan,
    required this.id,
    required this.idSampul,
    required this.judul,
    required this.penulis,
    required this.harga,
    required this.onTap,
    this.onChangeWishlist,
    this.copy,
  });
  final BukuPerpustakaan bukuPerpustakaan;
  final String id;
  final String idSampul;
  final String judul;
  final String penulis;
  final String harga;
  final String? copy;
  final Function() onTap;
  final Future<bool> Function()? onChangeWishlist;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
          color: Colors.white,
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            SizedBox(
              height: 160,
              child: Image.network(
                APIPath.publicAsset(idSampul),
                fit: BoxFit.cover,
                width: 200,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(Sizes.s),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    judul,
                    style: AppTextStyle.ts12Reg,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  VGap.xs,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          penulis,
                          style: AppTextStyle.ts12Bold.copyWith(color: AppColor.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      WishlistButton(
                        onChange: onChangeWishlist,
                        bukuPerpustakaan: bukuPerpustakaan,
                      ),
                    ],
                  ),
                  VGap.xs,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (copy != null) ...[
                        Text(
                          "Copy: $copy Buku",
                          style: AppTextStyle.ts10Reg.copyWith(color: AppColor.grey),
                        ),
                        HGap.s,
                      ],
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
            )
          ],
        ),
      ),
    );
  }
}
