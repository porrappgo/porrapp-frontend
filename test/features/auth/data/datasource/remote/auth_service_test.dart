import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/data/datasource/remote/auth_service.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

class MockDio extends Mock implements Dio {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockDio dio;
  late AuthService service;

  const MethodChannel channel = MethodChannel('flutter_logs');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return 'Ok';
    });

    dio = MockDio();
    service = AuthService(dio);
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('returns Success when API responds with 200', () async {
    // Arrange
    final authUser = AuthModel(email: 'user@example.com', name: 'Test User');
    final response = Response(
      requestOptions: RequestOptions(path: '/user/me/'),
      data: authUser.toJson(),
      statusCode: 200,
    );

    when(() => dio.get('/user/me/')).thenAnswer((_) async => response);

    // Act
    final result = await service.login();

    // Assert
    expect(result, isA<AuthModel>());
    expect(result.email, authUser.email);
    verify(() => dio.get('/user/me/')).called(1);
  });

  test('returns Error when API responds with non-200 status', () async {
    // Arrange
    final errorData = {"error": "Unauthorized"};

    final response = Response(
      requestOptions: RequestOptions(path: '/user/me/'),
      data: errorData,
      statusCode: 401,
    );

    when(() => dio.get('/user/me/')).thenAnswer((_) async => response);

    // Act & Assert
    expect(() => service.login(), throwsA(isA<ServerException>()));
  });
}
