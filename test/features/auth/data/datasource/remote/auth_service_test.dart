import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/data/datasource/remote/auth_service.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio dio;
  late AuthService service;

  setUp(() {
    dio = MockDio();
    service = AuthService(dio);
  });

  test('returns Success when API responds with 200', () async {
    final mockJson = {"email": "user@example.com", "name": "Test User"};

    final response = Response(
      requestOptions: RequestOptions(path: '/user/me/'),
      data: mockJson,
      statusCode: 200,
    );

    when(() => dio.get('/user/me/')).thenAnswer((_) async => response);

    final result = await service.login();
    expect(result, isA<Success<AuthModel>>());
    final authModel = (result as Success<AuthModel>).data;
    expect(authModel.email, 'user@example.com');
  });

  test('returns Success when API responds with 201', () async {
    final mockJson = {"email": "user@example.com", "name": "Test User"};

    final response = Response(
      requestOptions: RequestOptions(path: '/user/me/'),
      data: mockJson,
      statusCode: 201,
    );

    when(() => dio.get('/user/me/')).thenAnswer((_) async => response);

    final result = await service.login();
    expect(result, isA<Success<AuthModel>>());
  });

  test('returns Error when API responds with non-200/201 status', () async {
    final errorData = {"error": "Unauthorized"};

    final response = Response(
      requestOptions: RequestOptions(path: '/user/me/'),
      data: errorData,
      statusCode: 401,
    );

    when(() => dio.get('/user/me/')).thenAnswer((_) async => response);

    final result = await service.login();
    expect(result, isA<Error<dynamic>>());
  });

  test('returns Error when an exception is thrown', () async {
    when(() => dio.get('/user/me/')).thenThrow(Exception('Network error'));

    final result = await service.login();
    expect(result, isA<Error<dynamic>>());
  });
}
