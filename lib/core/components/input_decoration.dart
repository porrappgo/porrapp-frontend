import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration decoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(),
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
    );
  }
}
