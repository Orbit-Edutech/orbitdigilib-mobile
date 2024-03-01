import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

import '../../../constants/gaps.dart';
import '../../../constants/sizes.dart';
import '../../../shared/widget/app_button.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_stlye.dart';
import '../controller/book_controller.dart';

class OptionsCard extends StatelessWidget {
  const OptionsCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.suffix,
    this.enabled = true,
  });

  final String title;
  final String subtitle;
  final String? suffix;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = Get.find<BookController>();
    return Obx(() {
      final isSelected = controller.optionSelected.value == title;
      final state = controller.buttonState.value;
      return InkWell(
        onTap: state == ButtonState.loading || !enabled
            ? null
            : () {
                controller.optionSelected.value = title;
                controller.buttonState.value = ButtonState.enable;
              },
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: Sizes.s, horizontal: Sizes.r),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            border: Border.all(color: theme.primaryColor.withOpacity(enabled ? 1 : 0.5)),
          ),
          child: Row(
            children: [
              SvgPicture.string("""
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
            <circle cx="12" cy="12" r="12" fill="#D9D9D9"/>
            <circle cx="12" cy="12" r="8" fill="white"/>
            <circle cx="12" cy="12" r="4" fill="#${isSelected ? theme.primaryColor.value.toRadixString(16).substring(2) : "9E9E9E"} "/>
                  </svg>
                """),
              HGap.r,
              Expanded(
                child: Row(
                  children: [
                    Text(
                      "$title ",
                      style: AppTextStyle.ts14Bold.copyWith(
                        color: AppColor.black.withOpacity(enabled ? 1 : 0.5),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: AppTextStyle.ts12Reg.copyWith(
                        color: AppColor.black.withOpacity(enabled ? 1 : 0.5),
                      ),
                    ),
                  ],
                ),
              ),
              if (suffix != null)
                Text(
                  suffix!,
                  style: AppTextStyle.ts10Reg.copyWith(
                    color: AppColor.black.withOpacity(enabled ? 1 : 0.5),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
