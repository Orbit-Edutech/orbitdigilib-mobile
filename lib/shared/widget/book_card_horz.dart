import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../api/api_path.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';

class BookCardHorz extends StatelessWidget {
  const BookCardHorz({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {},
      child: Container(
        height: 100,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
          color: Colors.white,
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.network(
                APIPath.publicAsset("0696f2d7-942f-4e48-94ed-ef10d266263a"),
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
                      "Lorem",
                      style: AppTextStyle.ts14Bold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    VGap.s,
                    Text(
                      "Nama Pengarang",
                      style: AppTextStyle.ts14Light,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    VGap.s,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Copy: 10 Buku",
                          style: AppTextStyle.ts10Reg.copyWith(color: AppColor.grey),
                        ),
                        HGap.s,
                        SvgPicture.asset(
                          "assets/icons/coin.svg",
                          width: Sizes.sr,
                          colorFilter: ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
                        ),
                        Text(
                          "20",
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
