import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/gaps.dart';
import '../../theme/app_text_stlye.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key, required this.description, this.textAlign});

  final String description;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/illustrations/empty.svg",
          width: 200,
          fit: BoxFit.cover,
        ),
        VGap.r,
        Text(
          description,
          style: AppTextStyle.ts10Reg,
          textAlign: textAlign,
        ),
        const Row(), // in order to expand the width
      ],
    );
  }
}
