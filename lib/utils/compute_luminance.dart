import 'package:flutter/material.dart';

Color calculateLuminance(Color color) {
  final result = color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  return result;
}
