import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/core/components/input_decoration.dart';

void main() {
  group('InputDecorations', () {
    test('decoration creates InputDecoration with required parameters', () {
      final decoration = InputDecorations.decoration(
        hintText: 'Enter text',
        labelText: 'Label',
      );

      expect(decoration.hintText, 'Enter text');
      expect(decoration.labelText, 'Label');
      expect(decoration.prefixIcon, null);
      expect(decoration.suffixIcon, null);
    });

    test('decoration includes prefixIcon when provided', () {
      final decoration = InputDecorations.decoration(
        hintText: 'Enter email',
        labelText: 'Email',
        prefixIcon: Icons.email,
      );

      expect(decoration.prefixIcon, isNotNull);
      expect(decoration.prefixIcon, isA<Icon>());
    });

    test('decoration has OutlineInputBorder', () {
      final decoration = InputDecorations.decoration(
        hintText: 'Test',
        labelText: 'Test',
      );

      expect(decoration.border, isA<OutlineInputBorder>());
    });

    test('decoration includes suffixIcon for password field', () {
      final decoration = InputDecorations.decoration(
        hintText: 'Password',
        labelText: 'Password',
        isPassword: true,
      );

      expect(decoration.suffixIcon, isNotNull);
      expect(decoration.suffixIcon, isA<IconButton>());
    });

    test('decoration excludes suffixIcon when isPassword is false', () {
      final decoration = InputDecorations.decoration(
        hintText: 'Username',
        labelText: 'Username',
        isPassword: false,
      );

      expect(decoration.suffixIcon, null);
    });

    test('password visibility icon changes based on isObscure', () {
      final decorationObscured = InputDecorations.decoration(
        hintText: 'Password',
        labelText: 'Password',
        isPassword: true,
        isObscure: true,
      );

      final decorationVisible = InputDecorations.decoration(
        hintText: 'Password',
        labelText: 'Password',
        isPassword: true,
        isObscure: false,
      );

      expect(decorationObscured.suffixIcon, isNotNull);
      expect(decorationVisible.suffixIcon, isNotNull);
    });
  });
}
