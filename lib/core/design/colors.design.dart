import 'package:flutter/material.dart';

ColorScheme lightScheme() {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF050E3C),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFA3AEE6),
    onPrimaryContainer: Color(0xFF040C33),
    secondary: Color(0xFF002455),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFF9DBBE6),
    onSecondaryContainer: Color(0xFF001533),
    tertiary: Color(0xFFDC0000),
    onTertiary: Color(0xFFFFFFFF),
    tertiaryContainer: Color(0xFFE69D9D),
    onTertiaryContainer: Color(0xFF330000),
    error: Color(0xFFFF3838),
    onError: Color(0xFFFFFFFF),
    errorContainer: Color(0xFFE6ADAD),
    onErrorContainer: Color(0xFF330B0B),
    background: Color(0xFFfbfbfc),
    onBackground: Color(0xFF313133),
    surface: Color(0xFFfbfbfc),
    onSurface: Color(0xFF313133),
    surfaceVariant: Color(0xFFd8dae6),
    onSurfaceVariant: Color(0xFF535666),
    outline: Color(0xFF7d8199),
  );
}

ColorScheme darkScheme() {
  return const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF8796E6),
    onPrimary: Color(0xFF06124C),
    primaryContainer: Color(0xFF081766),
    onPrimaryContainer: Color(0xFFA3AEE6),
    secondary: Color(0xFF7FAAE6),
    onSecondary: Color(0xFF00204C),
    secondaryContainer: Color(0xFF002B66),
    onSecondaryContainer: Color(0xFF9DBBE6),
    tertiary: Color(0xFFE67F7F),
    onTertiary: Color(0xFF4C0000),
    tertiaryContainer: Color(0xFF660000),
    onTertiaryContainer: Color(0xFFE69D9D),
    error: Color(0xFFE69595),
    onError: Color(0xFF4C1111),
    errorContainer: Color(0xFF661616),
    onErrorContainer: Color(0xFFE6ADAD),
    background: Color(0xFF313133),
    onBackground: Color(0xFFe2e3e6),
    surface: Color(0xFF313133),
    onSurface: Color(0xFFe2e3e6),
    surfaceVariant: Color(0xFF535666),
    onSurfaceVariant: Color(0xFFd3d6e6),
    outline: Color(0xFF9ea1b3),
  );
}
