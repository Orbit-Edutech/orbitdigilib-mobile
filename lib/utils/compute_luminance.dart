import 'package:flutter/material.dart';

Color calculateLuminance(Color color) {
  final result = color.computeLuminance() > 0.75 ? Colors.black : Colors.white;
  return result;
}
