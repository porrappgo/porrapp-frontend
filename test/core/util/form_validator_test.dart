import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/core/util/util.dart';

void main() {
  group('FormatValidator - Email', () {
    test('isValidEmail returns true for valid email', () {
      expect(FormatValidator.isValidEmail('test@example.com'), isTrue);
    });

    test('isValidEmail returns false for invalid email', () {
      expect(FormatValidator.isValidEmail('invalid-email'), isFalse);
    });

    test('isValidEmailReturnErrorMessage returns error for empty email', () {
      expect(
        FormatValidator.isValidEmailReturnErrorMessage(''),
        'Email cannot be empty',
      );
    });

    test('isValidEmailReturnErrorMessage returns error for invalid email', () {
      expect(
        FormatValidator.isValidEmailReturnErrorMessage('invalid'),
        'Invalid email format',
      );
    });

    test('isValidEmailReturnErrorMessage returns null for valid email', () {
      expect(
        FormatValidator.isValidEmailReturnErrorMessage('user@mail.com'),
        isNull,
      );
    });
  });

  group('FormatValidator - Password', () {
    test('isValidPassword returns false for short password', () {
      expect(FormatValidator.isValidPassword('1234567'), isFalse);
    });

    test('isValidPassword returns true for valid password', () {
      expect(FormatValidator.isValidPassword('12345678'), isTrue);
    });

    test(
      'isValidPasswordReturnErrorMessage returns error for empty password',
      () {
        expect(
          FormatValidator.isValidPasswordReturnErrorMessage(''),
          'Password cannot be empty',
        );
      },
    );

    test(
      'isValidPasswordReturnErrorMessage returns error for short password',
      () {
        expect(
          FormatValidator.isValidPasswordReturnErrorMessage('1234567'),
          'Password must be at least 8 characters long.',
        );
      },
    );

    test(
      'isValidPasswordReturnErrorMessage returns null for valid password',
      () {
        expect(
          FormatValidator.isValidPasswordReturnErrorMessage('12345678'),
          isNull,
        );
      },
    );
  });

  group('FormatValidator - Password match', () {
    test('doPasswordsMatch returns error when passwords do not match', () {
      expect(
        FormatValidator.doPasswordsMatch('password1', 'password2'),
        'Passwords do not match',
      );
    });

    test('doPasswordsMatch returns null when passwords match', () {
      expect(FormatValidator.doPasswordsMatch('password', 'password'), isNull);
    });
  });

  group('FormatValidator - Name', () {
    test('isValidName returns error for empty name', () {
      expect(FormatValidator.isValidName(''), 'Name cannot be empty');
    });

    test('isValidName returns error for short name', () {
      expect(
        FormatValidator.isValidName('A'),
        'Name must be at least 2 characters long',
      );
    });

    test('isValidName returns null for valid name', () {
      expect(FormatValidator.isValidName('John'), isNull);
    });
  });
}
