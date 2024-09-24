import 'package:flutter/material.dart';

import '../../constants/sizes.dart';
import '../../theme/app_color.dart';

enum TextFieldType {
  normal,
  rounded,
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.type,
    required this.controller,
    required this.focusNode,
    required this.isError,
    required this.label,
    this.isObscure = false,
    this.autoFocus = false,
    this.onTapOutside,
    this.onChanged,
    this.errorText,
    this.suffix,
    this.enabled,
    this.contentPadding,
    this.keyboardType,
    this.onEditingComplete,
    this.onSubmitted,
    this.maxLines,
  });

  final TextFieldType type;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isError;
  final bool isObscure;
  final String? errorText;
  final Function(PointerDownEvent e)? onTapOutside;
  final Function(String text)? onChanged;
  final Function(String text)? onSubmitted;
  final Function()? onEditingComplete;
  final Widget label;
  final Widget? suffix;
  final bool? enabled;
  final bool autoFocus;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? keyboardType;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      controller: controller,
      focusNode: focusNode,
      onTapOutside: onTapOutside,
      onChanged: onChanged,
      obscureText: isObscure,
      autofocus: autoFocus,
      maxLines: maxLines ?? 1,
      decoration: InputDecoration(
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: Sizes.sm, vertical: Sizes.r),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(type == TextFieldType.normal ? Sizes.s : 99)),
          borderSide: const BorderSide(color: AppColor.lightGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(type == TextFieldType.normal ? Sizes.s : 99)),
          borderSide: const BorderSide(color: AppColor.lightGrey),
        ),
        label: label,
        errorText: isError ? errorText : null,
        errorStyle: errorText?.isEmpty ?? false ? const TextStyle(height: 0) : null,
        suffixIcon: suffix,
        suffixIconConstraints: const BoxConstraints(minWidth: 50),
      ),
      enabled: enabled,
      keyboardType: keyboardType,
    );
  }
}
