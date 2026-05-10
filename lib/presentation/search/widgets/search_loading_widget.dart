import 'package:flutter/material.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/book_card_skeleton.dart';
import '../../../theme/app_color.dart';
import '../../../utils/responsive_helper.dart';

class SearchLoadingWidget extends StatelessWidget {
  const SearchLoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(
        ResponsiveHelper.getHorizontalPadding(context),
      ),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (ctx, idx) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BookCardSkeleton(),
                HGap.m,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 25,
                        decoration: const BoxDecoration(
                          color: AppColor.lightGrey,
                          borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                        ),
                      ),
                      VGap.s,
                      Container(
                        height: 25,
                        decoration: const BoxDecoration(
                          color: AppColor.lightGrey,
                          borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                        ),
                      ),
                      VGap.s,
                      Container(
                        height: 25,
                        decoration: const BoxDecoration(
                          color: AppColor.lightGrey,
                          borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            VGap.s,
          ],
        );
      },
    );
  }
}
