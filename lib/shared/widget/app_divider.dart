import 'package:flutter/material.dart';

import '../../theme/app_color.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, required this.height, this.color, this.thickness});

  final double height;
  final double? thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: color ?? AppColor.lightGrey,
      thickness: thickness,
    );
  }
}
