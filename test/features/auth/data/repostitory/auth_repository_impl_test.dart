import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:porrapp_frontend/core/constants/constants.dart';
import 'package:porrapp_frontend/core/secure/secure_storage.dart';
import 'package:porrapp_frontend/core/util/resource.dart';
import 'package:porrapp_frontend/features/auth/data/datasource/remote/auth_service.dart';
import 'package:porrapp_frontend/features/auth/data/repository/auth_repository_impl.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

class MockAuthService extends Mock implements AuthService {}

class MockSecureStorage extends Mock implements ISecureStorageService {}

void main() {
  late MockAuthService mockAuthService;
  late MockSecureStorage mockSecureStorage;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockAuthService = MockAuthService();
    mockSecureStorage = MockSecureStorage();
    repository = AuthRepositoryImpl(mockAuthService, mockSecureStorage);
  });

  group('login', () {
    test('delegates login call to AuthService', () async {
      final mockResponse = Success<AuthModel>(
        AuthModel(email: 'test@test.com', name: 'Test User'),
      );

      when(() => mockAuthService.login()).thenAnswer((_) async => mockResponse);

      final result = await repository.login();

      expect(result, isA<Success<AuthModel>>());
      final success = result as Success<AuthModel>;
      expect(success.data.email, 'test@test.com');
      expect(success.data.name, 'Test User');

      verify(() => mockAuthService.login()).called(1);
    });
  });

  group('logout', () {
    test(
      'returns Success(true) when secureStorage.deleteAll succeeds',
      () async {
        when(() => mockSecureStorage.deleteAll()).thenAnswer((_) async {});
        when(() => mockSecureStorage.read(any())).thenAnswer((_) async => null);

        final result = await repository.logout();

        expect(result, isA<Success<bool>>());
        final success = result as Success<bool>;
        expect(success.data, true);

        verify(() => mockSecureStorage.deleteAll()).called(1);
        verify(
          () => mockSecureStorage.read(SecureStorageConstants.email),
        ).called(1);
        verify(
          () => mockSecureStorage.read(SecureStorageConstants.tokenAccess),
        ).called(1);
        verify(
          () => mockSecureStorage.read(SecureStorageConstants.tokenRefresh),
        ).called(1);
      },
    );

    test('returns Error when secureStorage.deleteAll throws', () async {
      when(
        () => mockSecureStorage.deleteAll(),
      ).thenThrow(Exception('storage error'));

      final result = await repository.logout();

      expect(result, isA<Error>());
      final error = result as Error;
      expect(error.message, 'Failed to logout');
    });
  });

  group('saveUserSession', () {
    test('saves user session with non-null refresh token', () async {
      when(
        () => mockSecureStorage.write(any(), any()),
      ).thenAnswer((_) async {});

      final result = await repository.saveUserSession(
        'email@test.com',
        'access',
        'refresh',
      );

      expect(result, true);

      verify(
        () => mockSecureStorage.write(
          SecureStorageConstants.email,
          'email@test.com',
        ),
      ).called(1);
      verify(
        () => mockSecureStorage.write(
          SecureStorageConstants.tokenAccess,
          'access',
        ),
      ).called(1);
      verify(
        () => mockSecureStorage.write(
          SecureStorageConstants.tokenRefresh,
          'refresh',
        ),
      ).called(1);
    });

    test('saves user session with null refresh token', () async {
      when(
        () => mockSecureStorage.write(any(), any()),
      ).thenAnswer((_) async {});

      final result = await repository.saveUserSession(
        'email@test.com',
        'access',
        null,
      );

      expect(result, true);

      verify(
        () => mockSecureStorage.write(
          SecureStorageConstants.email,
          'email@test.com',
        ),
      ).called(1);
      verify(
        () => mockSecureStorage.write(
          SecureStorageConstants.tokenAccess,
          'access',
        ),
      ).called(1);
      verifyNever(
        () =>
            mockSecureStorage.write(SecureStorageConstants.tokenRefresh, any()),
      );
    });
  });
}
