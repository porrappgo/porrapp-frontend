import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/core/util/util.dart';

void main() {
  group('BlocFormItem', () {
    test('default constructor sets empty value and null error', () {
      const item = BlocFormItem();

      expect(item.value, '');
      expect(item.error, isNull);
    });

    test('constructor sets value only', () {
      const item = BlocFormItem(value: 'test');

      expect(item.value, 'test');
      expect(item.error, isNull);
    });

    test('constructor sets error only', () {
      const item = BlocFormItem(error: 'error');

      expect(item.value, '');
      expect(item.error, 'error');
    });

    test('constructor sets value and error', () {
      const item = BlocFormItem(value: 'test', error: 'error');

      expect(item.value, 'test');
      expect(item.error, 'error');
    });

    test('copyWith with no parameters returns identical values', () {
      const item = BlocFormItem(value: 'value', error: 'error');

      final copy = item.copyWith();

      expect(copy.value, 'value');
      expect(copy.error, 'error');
      expect(identical(item, copy), isFalse);
    });

    test('copyWith overrides value only', () {
      const item = BlocFormItem(value: 'old', error: 'error');

      final copy = item.copyWith(value: 'new');

      expect(copy.value, 'new');
      expect(copy.error, 'error');
    });

    test('copyWith overrides error only', () {
      const item = BlocFormItem(value: 'value', error: 'old error');

      final copy = item.copyWith(error: 'new error');

      expect(copy.value, 'value');
      expect(copy.error, 'new error');
    });

    test('copyWith overrides value and error', () {
      const item = BlocFormItem(value: 'old', error: 'old error');

      final copy = item.copyWith(value: 'new', error: 'new error');

      expect(copy.value, 'new');
      expect(copy.error, 'new error');
    });

    test('BlocFormItem is immutable', () {
      const item = BlocFormItem(value: 'immutable', error: 'error');

      final copy = item.copyWith(value: 'changed');

      expect(item.value, 'immutable');
      expect(item.error, 'error');
      expect(copy.value, 'changed');
    });
  });
}
