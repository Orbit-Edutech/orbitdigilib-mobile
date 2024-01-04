import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../api/api_path.dart';
import '../../constants/gaps.dart';
import '../../constants/sizes.dart';
import '../../theme/app_color.dart';
import '../../theme/app_text_stlye.dart';

class BookCard extends StatefulWidget {
  const BookCard({
    super.key,
    required this.idSampul,
    required this.judul,
    required this.penulis,
    required this.harga,
    required this.isWishlist,
    required this.onTap,
    this.onChangeWishlist,
    this.copy,
  });
  final String idSampul;
  final String judul;
  final String penulis;
  final String harga;
  final String? copy;
  final bool isWishlist;
  final Function() onTap;
  final Function()? onChangeWishlist;

  @override
  State<BookCard> createState() => _BookCardState();
}

class _BookCardState extends State<BookCard> with SingleTickerProviderStateMixin {
  late bool isWishlist;
  Timer? _timer;

  late final _wishlistAnimationController = AnimationController(
    vsync: this,
    value: 1.0,
    duration: const Duration(milliseconds: 100),
  );

  @override
  void initState() {
    isWishlist = widget.isWishlist;
    super.initState();
  }

  @override
  void dispose() {
    _wishlistAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 140,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
          color: Colors.white,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            SizedBox(
              height: 160,
              child: Image.network(
                APIPath.publicAsset(widget.idSampul),
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
                    widget.judul,
                    style: AppTextStyle.ts12Reg,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  VGap.xs,
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.penulis,
                          style: AppTextStyle.ts12Bold.copyWith(color: AppColor.grey),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.onChangeWishlist;
                          if (_timer?.isActive ?? false) _timer?.cancel();
                          _timer = Timer(const Duration(milliseconds: 250), () {});
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
                      if (widget.copy != null) ...[
                        Text(
                          "Copy: ${widget.copy} Buku",
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
                        widget.harga,
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
