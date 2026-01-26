import 'package:dio/dio.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

class TokenService {
  static const String tag = "TokenService";

  final Dio _dio;

  TokenService(this._dio);

  Future<Resource<AuthTokenModel>> getToken(
    String email,
    String password,
  ) async {
    try {
      FlutterLogs.logInfo(
        tag,
        'getToken',
        'Attempting to get token for email: $email',
      );

      final response = await _dio.post(
        '/token/',
        data: {"email": email, "password": password},
        options: Options(extra: {"noAuth": true}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthTokenModel authResponse = AuthTokenModel.fromJson(response.data);
        return Success<AuthTokenModel>(authResponse);
      } else {
        return Error(response.data);
      }
    } catch (e) {
      // Handle error
      FlutterLogs.logError(tag, 'getToken', 'Error during getToken: $e');
      return Error('An error occurred during getToken: ${e.toString()}');
    }
  }

  Future<Resource<AuthTokenModel>> refreshToken(String refreshToken) async {
    try {
      FlutterLogs.logInfo(
        tag,
        'refreshToken',
        'Attempting to refresh token with access token: $refreshToken',
      );

      final response = await _dio.post(
        '/token/refresh/',
        data: {"refresh": refreshToken},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthTokenModel authResponse = AuthTokenModel.fromJson(response.data);
        return Success<AuthTokenModel>(authResponse);
      } else {
        return Error(response.data);
      }
    } catch (e) {
      // Handle error
      FlutterLogs.logError(
        tag,
        'refreshToken',
        'Error during refreshToken: $e',
      );
      return Error('An error occurred during refreshToken: ${e.toString()}');
    }
  }

  Future<Resource<AuthModel>> register(
    String email,
    String name,
    String password,
  ) async {
    try {
      FlutterLogs.logInfo(
        tag,
        'register',
        'Attempting to register user with email: $email, name: $name, password: $password',
      );

      final response = await _dio.post(
        '/user/create/',
        data: {"email": email, "password": password, "name": name},
        options: Options(extra: {"noAuth": true}),
      );
      FlutterLogs.logInfo(
        tag,
        'register',
        'Register response status: ${response.statusCode}, data: ${response.data}',
      );
      if (response.statusCode == 201) {
        AuthModel authResponse = AuthModel.fromJson(response.data);
        return Success<AuthModel>(authResponse);
      } else {
        return Error(response.data);
      }
    } catch (e) {
      // Handle error
      FlutterLogs.logError(tag, 'register', 'Error during register: $e');
      return Error('An error occurred during register: ${e.toString()}');
    }
  }
}
