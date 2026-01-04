import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:porrapp_frontend/core/secure/secure_storage.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late SecureStorage secureStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    secureStorage = SecureStorage(mockStorage);
  });

  group('SecureStorage', () {
    test('write delegates correctly to FlutterSecureStorage', () async {
      when(
        () => mockStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
          iOptions: any(named: 'iOptions'),
          aOptions: any(named: 'aOptions'),
        ),
      ).thenAnswer((_) async {});

      await secureStorage.write('token', '123');

      verify(
        () => mockStorage.write(
          key: 'token',
          value: '123',
          iOptions: any(named: 'iOptions', that: isA<IOSOptions>()),
          aOptions: any(named: 'aOptions', that: isA<AndroidOptions>()),
        ),
      ).called(1);
    });

    test('read returns value from FlutterSecureStorage', () async {
      when(
        () => mockStorage.read(
          key: any(named: 'key'),
          iOptions: any(named: 'iOptions'),
          aOptions: any(named: 'aOptions'),
        ),
      ).thenAnswer((_) async => 'stored_value');

      final result = await secureStorage.read('token');

      expect(result, 'stored_value');

      verify(
        () => mockStorage.read(
          key: 'token',
          iOptions: any(named: 'iOptions'),
          aOptions: any(named: 'aOptions'),
        ),
      ).called(1);
    });

    test('read returns null when key does not exist', () async {
      when(
        () => mockStorage.read(
          key: any(named: 'key'),
          iOptions: any(named: 'iOptions'),
          aOptions: any(named: 'aOptions'),
        ),
      ).thenAnswer((_) async => null);

      final result = await secureStorage.read('missing');

      expect(result, isNull);
    });

    test('delete delegates correctly to FlutterSecureStorage', () async {
      when(
        () => mockStorage.delete(
          key: any(named: 'key'),
          iOptions: any(named: 'iOptions'),
          aOptions: any(named: 'aOptions'),
        ),
      ).thenAnswer((_) async {});

      await secureStorage.delete('token');

      verify(
        () => mockStorage.delete(
          key: 'token',
          iOptions: any(named: 'iOptions'),
          aOptions: any(named: 'aOptions'),
        ),
      ).called(1);
    });

    test('deleteAll delegates correctly to FlutterSecureStorage', () async {
      when(
        () => mockStorage.deleteAll(
          iOptions: any(named: 'iOptions'),
          aOptions: any(named: 'aOptions'),
        ),
      ).thenAnswer((_) async {});

      await secureStorage.deleteAll();

      verify(
        () => mockStorage.deleteAll(
          iOptions: any(named: 'iOptions'),
          aOptions: any(named: 'aOptions'),
        ),
      ).called(1);
    });

    test('implements ISecureStorageService interface', () {
      expect(secureStorage, isA<ISecureStorageService>());
    });
  });
}
