import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:porrapp_frontend/core/constants/constants.dart';
import 'package:porrapp_frontend/core/secure/secure_storage.dart';
import 'package:porrapp_frontend/core/util/resource.dart';
import 'package:porrapp_frontend/features/auth/data/datasource/remote/token_service.dart';
import 'package:porrapp_frontend/features/auth/data/repository/token_refresher_repository_impl.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

class MockTokenService extends Mock implements TokenService {}

class MockSecureStorage extends Mock implements ISecureStorageService {}

void main() {
  late MockTokenService mockTokenService;
  late MockSecureStorage mockSecureStorage;
  late TokenRefresherRepositoryImpl repository;

  setUp(() {
    mockTokenService = MockTokenService();
    mockSecureStorage = MockSecureStorage();
    repository = TokenRefresherRepositoryImpl(
      mockTokenService,
      mockSecureStorage,
    );
  });

  group('refreshAccessToken', () {
    test('returns null if refresh token is not in secure storage', () async {
      when(
        () => mockSecureStorage.read(SecureStorageConstants.tokenRefresh),
      ).thenAnswer((_) async => null);

      final result = await repository.refreshAccessToken();

      expect(result, isNull);
      verify(
        () => mockSecureStorage.read(SecureStorageConstants.tokenRefresh),
      ).called(1);
    });

    test(
      'returns Success<String> and updates secure storage on successful refresh',
      () async {
        when(
          () => mockSecureStorage.read(SecureStorageConstants.tokenRefresh),
        ).thenAnswer((_) async => 'refresh_token');

        final authTokenModel = AuthTokenModel(
          access: 'new_access',
          refresh: 'refresh_token',
        );
        when(
          () => mockTokenService.refreshToken('refresh_token'),
        ).thenAnswer((_) async => Success<AuthTokenModel>(authTokenModel));

        when(
          () => mockSecureStorage.write(
            SecureStorageConstants.tokenAccess,
            any(),
          ),
        ).thenAnswer((_) async {});

        final result = await repository.refreshAccessToken();

        expect(result, isA<Success<String>>());
        final success = result as Success<String>;
        expect(success.data, 'new_access');

        verify(
          () => mockSecureStorage.write(
            SecureStorageConstants.tokenAccess,
            'new_access',
          ),
        ).called(1);
      },
    );

    test('returns null if refresh token request fails', () async {
      when(
        () => mockSecureStorage.read(SecureStorageConstants.tokenRefresh),
      ).thenAnswer((_) async => 'refresh_token');

      when(
        () => mockTokenService.refreshToken('refresh_token'),
      ).thenAnswer((_) async => Error('Invalid token'));

      final result = await repository.refreshAccessToken();

      expect(result, isNull);
    });
  });

  group('getToken', () {
    test('delegates getToken to TokenService', () async {
      final authTokenModel = AuthTokenModel(
        access: 'access',
        refresh: 'refresh',
      );
      when(
        () => mockTokenService.getToken('email', 'pass'),
      ).thenAnswer((_) async => Success(authTokenModel));

      final result = await repository.getToken('email', 'pass');

      expect(result, isA<Success<AuthTokenModel>>());
      final success = result as Success<AuthTokenModel>;
      expect(success.data.access, 'access');
      expect(success.data.refresh, 'refresh');

      verify(() => mockTokenService.getToken('email', 'pass')).called(1);
    });
  });

  group('registerUser', () {
    test('delegates register to TokenService', () async {
      final authModel = AuthModel(email: 'email', name: 'Name');
      when(
        () => mockTokenService.register('email', 'Name', 'pass'),
      ).thenAnswer((_) async => Success(authModel));

      final result = await repository.registerUser('email', 'Name', 'pass');

      expect(result, isA<Success<AuthModel>>());
      final success = result as Success<AuthModel>;
      expect(success.data.email, 'email');
      expect(success.data.name, 'Name');

      verify(
        () => mockTokenService.register('email', 'Name', 'pass'),
      ).called(1);
    });
  });
}
