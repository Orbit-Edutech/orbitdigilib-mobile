import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../api/api_path.dart';
import '../../../api/buku-perpustakaan/model/model_one_buku_perpustakaan.dart';

class BookBackgroundBlur extends StatelessWidget {
  const BookBackgroundBlur({
    super.key,
    required this.book,
  });

  final Buku? book;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(APIPath.publicAsset(book?.assetSampulId ?? '')),
          alignment: Alignment.topCenter,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
        ),
      ),
    );
  }
}
