import 'package:flutter/material.dart';

/// Provides static methods for creating customized [InputDecoration] instances.
///
/// This class contains factory methods that generate [InputDecoration] objects
/// with consistent styling and behavior patterns used throughout the application.
class InputDecorations {
  /// Creates a configured [InputDecoration] with optional password visibility toggle.
  ///
  /// Parameters:
  ///   - [hintText]: The hint text displayed in the input field when empty.
  ///   - [labelText]: The label text displayed above or as part of the border.
  ///   - [prefixIcon]: Optional icon displayed at the start of the input field.
  ///   - [isPassword]: Whether this input field is for password entry (default: false).
  ///   - [isObscure]: Whether the password text should be hidden (default: false).
  ///   - [onTogglePasswordVisibility]: Callback triggered when the password visibility
  ///     toggle button is pressed. Only used when [isPassword] is true.
  ///
  /// Returns:
  ///   An [InputDecoration] with an outline border, customized labels, icons,
  ///   and optional password visibility toggle functionality.
  ///
  /// Example:
  /// ```dart
  /// final decoration = InputDecorations.decoration(
  ///   hintText: 'Enter your email',
  ///   labelText: 'Email',
  ///   prefixIcon: Icons.email,
  /// );
  /// ```
  static InputDecoration decoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
    bool isPassword = false,
    bool isObscure = false,
    VoidCallback? onTogglePasswordVisibility,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(),
      hintText: hintText,
      labelText: labelText,
      prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
              onPressed: onTogglePasswordVisibility,
            )
          : null,
    );
  }
}
