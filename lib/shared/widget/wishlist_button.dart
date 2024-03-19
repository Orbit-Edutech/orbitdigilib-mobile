import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/wishlist/data/wishlist_create_one.dart';
import '../../api/wishlist/data/wishlist_delete_one.dart';
import '../../api/wishlist/model/model_wishlist_all.dart';
import '../../presentation/wishlist/controller/wishlist_controller.dart';

class WishlistButton extends StatefulWidget {
  const WishlistButton({super.key, this.onChange, required this.bukuPerpustakaan, this.color});

  final Future<bool> Function()? onChange;
  final BukuPerpustakaan bukuPerpustakaan;
  final Color? color;

  @override
  State<WishlistButton> createState() => _WishlistButtonState();
}

class _WishlistButtonState extends State<WishlistButton> with SingleTickerProviderStateMixin {
  CancelToken postCancelToken = CancelToken();
  CancelToken delCancelToken = CancelToken();
  Timer? timer;
  bool? isWishlist;
  final wishlistController = Get.find<WishlistController>();

  late AnimationController wishlistAnimationController = AnimationController(
    vsync: this,
    value: 1.0,
    duration: const Duration(milliseconds: 100),
  );

  @override
  void initState() {
    wishlistAnimationController = AnimationController(
      vsync: this,
      value: 1.0,
      duration: const Duration(milliseconds: 100),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!wishlistController.initialized) {
        wishlistController.onInit().then((_) {
          setState(() {
            isWishlist = wishlistController.wishlist.value?.firstWhereOrNull((wishlist) {
                  final result = wishlist.bukuPerpustakaan?.id == widget.bukuPerpustakaan.id;
                  return result;
                }) !=
                null;
          });
        });
      } else {
        setState(() {
          isWishlist = wishlistController.wishlist.value?.firstWhereOrNull((wishlist) {
                final result = wishlist.bukuPerpustakaan?.id == widget.bukuPerpustakaan.id;
                return result;
              }) !=
              null;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    wishlistAnimationController.dispose();
    super.dispose();
  }

  void hitWishlistEndPoint(WishlistController controller) async {
    if (timer?.isActive ?? true) timer?.cancel();
    if (controller.wishlist.value?.firstWhereOrNull((wishlist) {
          final result = wishlist.bukuPerpustakaan?.id == widget.bukuPerpustakaan.id;
          return result;
        }) !=
        null) {
      delCancelToken.cancel();
      delCancelToken = CancelToken();
      await deleteOneWishlist(widget.bukuPerpustakaan.id!, delCancelToken);
      final filteredWishlist = controller.filteredWishlist.value;
      filteredWishlist?.removeWhere(
        (wishlist) => wishlist.bukuPerpustakaan?.id == widget.bukuPerpustakaan.id,
      );
      controller.filteredWishlist.value = filteredWishlist;
      controller.update();
    } else {
      postCancelToken.cancel();
      postCancelToken = CancelToken();
      final response = await createOneWishlist(widget.bukuPerpustakaan.id!, postCancelToken);
      if (response.data != null) {
        final filteredWishlist = controller.filteredWishlist.value;
        final wishlist = Wishlist.fromJson({"bukuPerpustakaan": widget.bukuPerpustakaan.toJson()});
        filteredWishlist?.add(wishlist);
        controller.filteredWishlist.value = filteredWishlist;
        controller.update();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (isWishlist == null) return const SizedBox();
    return GetBuilder<WishlistController>(builder: (WishlistController controller) {
      final wishlist = controller.wishlist.value;
      if (wishlist == null) return const SizedBox();
      return GestureDetector(
        onTap: () async {
          if (isWishlist!) {
            final bool result = await (widget.onChange ?? () async => true)();
            if (result) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                hitWishlistEndPoint(controller);
              });
              wishlistAnimationController.reverse().then((value) => wishlistAnimationController.forward());
            }
          } else {
            setState(() => isWishlist = !isWishlist!);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              hitWishlistEndPoint(controller);
            });
            wishlistAnimationController.reverse().then((value) => wishlistAnimationController.forward());
          }
        },
        child: ScaleTransition(
          scale: Tween(begin: 0.7, end: 1.0).animate(
            CurvedAnimation(
              parent: wishlistAnimationController,
              curve: Curves.easeOut,
            ),
          ),
          child: Icon(
            controller.wishlist.value?.firstWhereOrNull((wishlist) {
                      final result = wishlist.bukuPerpustakaan?.id == widget.bukuPerpustakaan.id;
                      return result;
                    }) !=
                    null
                ? Icons.bookmark_rounded
                : Icons.bookmark_outline_rounded,
            color: widget.color ?? theme.primaryColor,
            size: 24,
          ),
        ),
      );
    });
  }
}
