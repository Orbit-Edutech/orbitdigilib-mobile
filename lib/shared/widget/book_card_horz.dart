import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';

class BookCardHorz extends StatefulWidget {
  const BookCardHorz({super.key});

  @override
  State<BookCardHorz> createState() => _BookCardHorzState();
}

class _BookCardHorzState extends State<BookCardHorz> with SingleTickerProviderStateMixin {
  bool isWishlist = false;
  late final _wishlistAnimationController = AnimationController(
    vsync: this,
    value: 1.0,
    duration: const Duration(milliseconds: 100),
  );

  @override
  void didChangeDependencies() {
    _wishlistAnimationController.dispose();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    debugPrint("REBUILDING");
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
        boxShadow: [
          BoxShadow(
            color: AppColor.grey.withOpacity(.1),
            offset: const Offset(2, 2),
            blurRadius: 10,
            spreadRadius: 1,
            blurStyle: BlurStyle.normal,
          ),
        ],
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
            child: Image.asset(
              "assets/icons/kategori/cover.jpg",
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Judul Buku Satu",
                    style: AppTextStyle.ts14Bold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Nama Pengarang",
                    style: AppTextStyle.ts14Light,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/coin.svg",
                        width: Sizes.sr,
                        colorFilter: ColorFilter.mode(theme.primaryColor, BlendMode.srcIn),
                      ),
                      Text(
                        "20",
                        style: AppTextStyle.ts10Bold.copyWith(color: theme.primaryColor),
                      ),
                      HGap.s,
                      Text(
                        "Copy: 10 Buku",
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
}
