import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:porrapp_frontend/core/constants/constants.dart';
import 'package:porrapp_frontend/core/secure/secure_storage.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/data/datasource/remote/auth_interceptor.dart';
import 'package:porrapp_frontend/features/auth/domain/repository/token_refresher_repository.dart';

class MockSecureStorage extends Mock implements ISecureStorageService {}

class MockTokenRefresherRepository extends Mock
    implements TokenRefresherRepository {}

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

class MockDio extends Mock implements Dio {}

// Fakes necesarios para cualquier uso de `any()` en Mocktail
class FakeRequestOptions extends Fake implements RequestOptions {}

class FakeDioException extends Fake implements DioException {}

class FakeResponse extends Fake implements Response<dynamic> {}

void main() {
  late MockDio dio;
  late MockSecureStorage secureStorage;
  late MockTokenRefresherRepository tokenRefresherRepository;
  late AuthInterceptor interceptor;

  setUpAll(() {
    // Registrar todos los fakes usados en any()
    registerFallbackValue(FakeRequestOptions());
    registerFallbackValue(FakeDioException());
    registerFallbackValue(FakeResponse());
  });

  setUp(() {
    dio = MockDio();
    secureStorage = MockSecureStorage();
    tokenRefresherRepository = MockTokenRefresherRepository();
    interceptor = AuthInterceptor(dio, secureStorage, tokenRefresherRepository);
  });

  group('AuthInterceptor - onRequest', () {
    test('adds Authorization header when token is available', () async {
      final completer = Completer<void>();

      when(
        () => secureStorage.read(SecureStorageConstants.tokenAccess),
      ).thenAnswer((_) async => 'access_token');

      final options = RequestOptions(path: '/test');
      final handler = MockRequestInterceptorHandler();

      when(() => handler.next(any())).thenAnswer((_) {
        completer.complete();
      });

      interceptor.onRequest(options, handler);
      await completer.future;

      expect(options.headers['Authorization'], equals('Bearer access_token'));
      verify(() => handler.next(options)).called(1);
    });

    test('does NOT add Authorization header when noAuth is true', () async {
      final completer = Completer<void>();
      final options = RequestOptions(path: '/test', extra: {'noAuth': true});
      final handler = MockRequestInterceptorHandler();

      when(() => handler.next(any())).thenAnswer((_) {
        completer.complete();
      });

      interceptor.onRequest(options, handler);
      await completer.future;

      expect(options.headers.containsKey('Authorization'), isFalse);
      verifyNever(() => secureStorage.read(SecureStorageConstants.tokenAccess));
      verify(() => handler.next(options)).called(1);
    });
  });

  group('AuthInterceptor - onError', () {
    test(
      'refreshes token and retries request when statusCode is 401 and refresh succeeds',
      () async {
        final completer = Completer<void>();

        when(
          () => tokenRefresherRepository.refreshAccessToken(),
        ).thenAnswer((_) async => Success('new_access_token'));

        when(() => dio.fetch(any())).thenAnswer(
          (_) async => Response(
            requestOptions: RequestOptions(path: '/test'),
            statusCode: 200,
          ),
        );

        final requestOptions = RequestOptions(
          path: '/test',
          method: 'GET',
          headers: {},
        );
        final dioException = DioException(
          requestOptions: requestOptions,
          response: Response(requestOptions: requestOptions, statusCode: 401),
        );

        final handler = MockErrorInterceptorHandler();
        when(() => handler.resolve(any())).thenAnswer((_) {
          completer.complete();
        });

        interceptor.onError(dioException, handler);
        await completer.future;

        verify(() => tokenRefresherRepository.refreshAccessToken()).called(1);
        verify(() => dio.fetch(any())).called(1);
        verify(() => handler.resolve(any())).called(1);
      },
    );

    test('continues error when refresh fails', () async {
      final completer = Completer<void>();

      when(
        () => tokenRefresherRepository.refreshAccessToken(),
      ).thenAnswer((_) async => Error('refresh failed'));

      final requestOptions = RequestOptions(path: '/test');
      final dioException = DioException(
        requestOptions: requestOptions,
        response: Response(requestOptions: requestOptions, statusCode: 401),
      );

      final handler = MockErrorInterceptorHandler();
      when(() => handler.next(any())).thenAnswer((_) {
        completer.complete();
      });

      interceptor.onError(dioException, handler);
      await completer.future;

      verify(() => handler.next(dioException)).called(1);
    });

    test('continues error when noAuth is true', () async {
      final completer = Completer<void>();

      final requestOptions = RequestOptions(
        path: '/test',
        extra: {'noAuth': true},
      );
      final dioException = DioException(
        requestOptions: requestOptions,
        response: Response(requestOptions: requestOptions, statusCode: 401),
      );

      final handler = MockErrorInterceptorHandler();
      when(() => handler.next(any())).thenAnswer((_) {
        completer.complete();
      });

      interceptor.onError(dioException, handler);
      await completer.future;

      verifyNever(() => tokenRefresherRepository.refreshAccessToken());
      verify(() => handler.next(dioException)).called(1);
    });
  });
}
