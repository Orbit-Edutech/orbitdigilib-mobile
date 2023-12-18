import 'package:flutter/material.dart';

import '../../constants/sizes.dart';

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
    this.onTapOutside,
    this.onChanged,
    this.errorText,
  });

  final TextFieldType type;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isError;
  final String? errorText;
  final Function(PointerDownEvent e)? onTapOutside;
  final Function(String text)? onChanged;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case TextFieldType.normal:
        return TextField(
          controller: controller,
          focusNode: focusNode,
          onTapOutside: onTapOutside,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: Sizes.sm, vertical: Sizes.r),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(Sizes.s)),
            ),
            label: label,
            errorText: isError ? errorText : null,
          ),
        );
      case TextFieldType.rounded:
        return TextField(
          controller: controller,
          focusNode: focusNode,
          onTapOutside: onTapOutside,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: Sizes.sm, vertical: Sizes.r),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(99)),
            ),
            label: label,
            errorText: isError ? errorText : null,
          ),
        );
    }
  }
}
