import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';

class BookCard extends StatefulWidget {
  const BookCard({super.key});

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> with SingleTickerProviderStateMixin {
  bool isWishlist = false;
  late final _wishlistAnimationController = AnimationController(
    vsync: this,
    value: 1.0,
    duration: const Duration(milliseconds: 100),
  );

  @override
  void dispose() {
    _wishlistAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 140,
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
      child: Column(
        children: [
          SizedBox(
            height: 160,
            child: Image.asset(
              "assets/icons/kategori/cover.jpg",
              fit: BoxFit.cover,
              width: 200,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(Sizes.s),
            child: Column(
              children: [
                Text(
                  "Lorem Ipsum Dolor Sit amet Lorem Ipsum Dolor sit Amet",
                  style: AppTextStyle.ts12Reg,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                VGap.xs,
                Row(
                  children: [
                    Text(
                      "Tere Liye",
                      style: AppTextStyle.ts12Bold.copyWith(color: AppColor.grey),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        setState(() => isWishlist = !isWishlist);
                        _wishlistAnimationController.reverse().then((value) => _wishlistAnimationController.forward());
                      },
                      child: ScaleTransition(
                        scale: Tween(begin: 0.7, end: 1.0).animate(
                          CurvedAnimation(
                            parent: _wishlistAnimationController,
                            curve: Curves.easeOut,
                          ),
                        ),
                        child: Icon(
                          isWishlist ? Icons.bookmark_outline_rounded : Icons.bookmark_rounded,
                          color: theme.primaryColor,
                          size: 24,
                        ),
                      ),
                    )
                  ],
                ),
                VGap.xs,
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
          )
        ],
      ),
    );
  }
}
