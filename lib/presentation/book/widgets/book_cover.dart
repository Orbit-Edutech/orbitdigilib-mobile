import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../api/api_path.dart';
import '../../../api/buku-perpustakaan/model/model_one_buku_perpustakaan.dart';
import '../../../constants/sizes.dart';

class BookCover extends StatelessWidget {
  const BookCover({
    super.key,
    required this.book,
  });
  final Buku? book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Positioned(
      top: -100,
      child: Container(
        width: 160,
        height: 200,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: theme.primaryColor),
          image: book?.assetSampulId == null
              ? null
              : DecorationImage(
                  image: CachedNetworkImageProvider(
                    APIPath.publicAsset(book?.assetSampulId ?? ""),
                  ),
                  fit: BoxFit.cover,
                ),
          borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
        ),
        child: book?.assetSampulId == null
            ? const Text(
                "Sampul Kosong",
                textAlign: TextAlign.center,
              )
            : null,
      ),
    );
  }
}
