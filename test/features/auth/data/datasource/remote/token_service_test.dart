import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';

import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/data/datasource/remote/token_service.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

class MockDio extends Mock implements Dio {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockDio mockDio;
  late TokenService tokenService;

  const MethodChannel channel = MethodChannel('flutter_logs');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return 'Ok';
    });

    mockDio = MockDio();
    tokenService = TokenService(mockDio);
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  group('TokenService - getToken', () {
    test('returns Success<AuthTokenModel> when statusCode is 200', () async {
      final responseData = {
        "access": "access_token",
        "refresh": "refresh_token",
      };

      when(
        () => mockDio.post(
          '/token/',
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/token/'),
          statusCode: 200,
          data: responseData,
        ),
      );

      final result = await tokenService.getToken('test@test.com', '123456');

      expect(result, isA<Success<AuthTokenModel>>());
    });

    test('returns Error when statusCode is not 200 or 201', () async {
      when(
        () => mockDio.post(
          '/token/',
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/token/'),
          statusCode: 400,
          data: {'detail': 'Invalid credentials'},
        ),
      );

      final result = await tokenService.getToken('test@test.com', 'wrong');

      expect(result, isA<Error>());
    });

    test('returns Error when Dio throws exception', () async {
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/token/')),
      );

      final result = await tokenService.getToken('test@test.com', '123456');

      expect(result, isA<Error>());
    });
  });

  group('TokenService - refreshToken', () {
    test('returns Success<AuthTokenModel> when statusCode is 200', () async {
      final responseData = {"access": "new_access", "refresh": "new_refresh"};

      when(
        () => mockDio.post('/token/refresh/', data: any(named: 'data')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/token/refresh/'),
          statusCode: 200,
          data: responseData,
        ),
      );

      final result = await tokenService.refreshToken('refresh_token');

      expect(result, isA<Success<AuthTokenModel>>());
    });

    test('returns Error when statusCode is not 200 or 201', () async {
      when(
        () => mockDio.post('/token/refresh/', data: any(named: 'data')),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/token/refresh/'),
          statusCode: 401,
          data: {'detail': 'Token expired'},
        ),
      );

      final result = await tokenService.refreshToken('expired_token');

      expect(result, isA<Error>());
    });

    test('returns Error when exception occurs', () async {
      when(() => mockDio.post(any(), data: any(named: 'data'))).thenThrow(
        DioException(requestOptions: RequestOptions(path: '/token/refresh/')),
      );

      final result = await tokenService.refreshToken('refresh_token');

      expect(result, isA<Error>());
    });
  });

  group('TokenService - register', () {
    test('returns Success<AuthModel> when statusCode is 201', () async {
      final responseData = {
        "id": 1,
        "email": "test@test.com",
        "name": "Test User",
      };

      when(
        () => mockDio.post(
          '/user/create/',
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/user/create/'),
          statusCode: 201,
          data: responseData,
        ),
      );

      final result = await tokenService.register(
        'test@test.com',
        'Test User',
        '123456',
      );

      expect(result, isA<Success<AuthModel>>());
    });

    test('returns Error when statusCode is not 201', () async {
      when(
        () => mockDio.post(
          '/user/create/',
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenAnswer(
        (_) async => Response(
          requestOptions: RequestOptions(path: '/user/create/'),
          statusCode: 400,
          data: {
            'email': ['Already exists'],
          },
        ),
      );

      final result = await tokenService.register(
        'test@test.com',
        'Test User',
        '123456',
      );

      expect(result, isA<Error>());
    });

    test('returns Error when exception occurs', () async {
      when(
        () => mockDio.post(
          any(),
          data: any(named: 'data'),
          options: any(named: 'options'),
        ),
      ).thenThrow(Exception('Network error'));

      final result = await tokenService.register(
        'test@test.com',
        'Test User',
        '123456',
      );

      expect(result, isA<Error>());
    });
  });
}
