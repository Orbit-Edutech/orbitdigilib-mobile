import 'package:flutter/material.dart';

import '../../constants/sizes.dart';
import '../../theme/app_color.dart';

class BookCardSkeleton extends StatelessWidget {
  const BookCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 175,
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
        color: AppColor.lightGrey,
      ),
    );
  }
}
