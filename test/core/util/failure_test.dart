import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/core/util/failure.dart';

void main() {
  group('Failure Classes', () {
    test('InternalFailure should have correct message', () {
      const failure = InternalFailure('Internal error');
      expect(failure.message, 'Internal error');
    });

    test('ServerFailure should have correct message', () {
      const failure = ServerFailure('Server error');
      expect(failure.message, 'Server error');
    });

    test('ConnectionFailure should have correct message', () {
      const failure = ConnectionFailure('Connection error');
      expect(failure.message, 'Connection error');
    });

    test('DatabaseFailure should have correct message', () {
      const failure = DatabaseFailure('Database error');
      expect(failure.message, 'Database error');
    });

    test('Failures with same message should be equal', () {
      const failure1 = InternalFailure('Error');
      const failure2 = InternalFailure('Error');
      expect(failure1, failure2);
    });

    test('Failures with different messages should not be equal', () {
      const failure1 = InternalFailure('Error 1');
      const failure2 = InternalFailure('Error 2');
      expect(failure1, isNot(failure2));
    });

    test('Different failure types should not be equal', () {
      const failure1 = InternalFailure('Error');
      const failure2 = ServerFailure('Error');
      expect(failure1, isNot(failure2));
    });

    test('Failure props should contain message', () {
      const failure = ConnectionFailure('Test message');
      expect(failure.props, ['Test message']);
    });
  });
}
