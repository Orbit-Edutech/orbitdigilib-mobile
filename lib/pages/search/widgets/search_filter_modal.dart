import 'package:flutter/material.dart';

import '../../../constants/sizes.dart';
import '../../../theme/app_color.dart';

class SearchFilterModal extends StatelessWidget {
  const SearchFilterModal({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * .75,
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.l)),
      ),
      child: Column(),
    );
  }
}
