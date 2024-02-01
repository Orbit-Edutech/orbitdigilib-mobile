import 'package:flutter/material.dart';

import '../../../api/api_path.dart';
import '../../../api/voucher-info/model/model_voucher_info_all.dart' as v;
import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import '../../../utils/launch_url.dart';

class TokenInfoCard extends StatelessWidget {
  const TokenInfoCard({super.key, required this.option});

  final v.GetVoucher option;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () => launchUrl(option.link ?? ""),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Sizes.s, horizontal: Sizes.r),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(Sizes.s)),
          border: Border.all(color: AppColor.lightGrey, width: 1),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(Sizes.xs)),
                image: DecorationImage(
                  image: NetworkImage(APIPath.publicAsset(option.icon?.id ?? "")),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            HGap.r,
            Text(option.judul ?? "-", style: AppTextStyle.ts14Reg),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, color: theme.primaryColor),
          ],
        ),
      ),
    );
  }
}
