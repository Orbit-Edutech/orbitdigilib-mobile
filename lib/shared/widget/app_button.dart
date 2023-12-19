import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../constants/sizes.dart';

enum ButtonType {
  elevated,
  outlined,
  text,
}

enum ButtonState {
  enable,
  disable,
  loading,
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.state = ButtonState.enable,
    required this.type,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth,
    this.padding,
  });

  final ButtonType type;
  final ButtonState state;
  final Widget child;
  final void Function() onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return _buildButton(context);
  }

  Widget _buildButton(BuildContext context) {
    switch (type) {
      case ButtonType.elevated:
        return buildElevatedButton(context);
      case ButtonType.outlined:
        return buildOutlinedButton();
      case ButtonType.text:
        return buildTextButton();
    }
  }

  Widget buildElevatedButton(BuildContext context) {
    return ElevatedButton(
      onPressed: state == ButtonState.enable ? onPressed : null,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: backgroundColor ?? Get.theme.primaryColor,
        foregroundColor: foregroundColor ?? Colors.white,
        disabledBackgroundColor: (backgroundColor ?? Get.theme.primaryColor).withOpacity(.5),
        disabledForegroundColor: Colors.white.withOpacity(.5),
        padding: padding ?? const EdgeInsets.symmetric(vertical: Sizes.s, horizontal: Sizes.r),
        minimumSize: Size.zero,
      ),
      child: state == ButtonState.loading
          ? SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                color: (foregroundColor ?? Colors.white).withOpacity(.5),
                strokeWidth: 2.0,
              ),
            )
          : child,
    );
  }

  Widget buildOutlinedButton() {
    return OutlinedButton(
      onPressed: state == ButtonState.enable ? onPressed : null,
      style: OutlinedButton.styleFrom(
        foregroundColor: foregroundColor ?? Get.theme.primaryColor,
        backgroundColor: backgroundColor ?? Colors.transparent,
        disabledForegroundColor: foregroundColor ?? Get.theme.primaryColor.withOpacity(.5),
        side: BorderSide(
          color: (borderColor ?? Get.theme.primaryColor).withOpacity(state == ButtonState.enable ? 1 : .5),
          width: borderWidth ?? 1.0,
        ),
        padding: padding ?? const EdgeInsets.symmetric(vertical: Sizes.s, horizontal: Sizes.r),
      ),
      child: state == ButtonState.loading
          ? SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                color: (foregroundColor ?? Get.theme.primaryColor).withOpacity(.5),
                strokeWidth: 2.0,
              ),
            )
          : child,
    );
  }

  Widget buildTextButton() {
    return TextButton(
      onPressed: state == ButtonState.enable ? onPressed : null,
      style: TextButton.styleFrom(
        foregroundColor: foregroundColor ?? Get.theme.primaryColor,
        backgroundColor: backgroundColor ?? Colors.transparent,
        disabledForegroundColor: foregroundColor ?? Get.theme.primaryColor.withOpacity(.5),
        padding: padding ?? const EdgeInsets.symmetric(vertical: Sizes.s, horizontal: Sizes.r),
      ),
      child: state == ButtonState.loading
          ? SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                color: (foregroundColor ?? Get.theme.primaryColor).withOpacity(.5),
                strokeWidth: 2.0,
              ),
            )
          : child,
    );
  }
}
