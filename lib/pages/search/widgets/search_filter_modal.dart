import 'package:flutter/material.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../theme/app_color.dart';
import 'search_filter_latter.dart';
import 'search_filter_modal_buttons.dart';
import 'search_filter_price.dart';

class SearchFilterModal extends StatelessWidget {
  const SearchFilterModal({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * .5,
      decoration: const BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.l)),
      ),
      padding: const EdgeInsets.symmetric(vertical: Sizes.m),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                SearchFilterLetter(),
                VGap.r,
                SearchFilterPrice(),
              ],
            ),
          ),
          SearchFilterModalButtons()
        ],
      ),
    );
  }
}
