import 'package:dio/dio.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

class TokenService {
  final Dio _dio;

  TokenService(this._dio);

  Future<Resource<AuthTokenModel>> getToken(
    String email,
    String password,
  ) async {
    try {
      print(
        'Attempting to get token for email: $email and password: $password',
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
      print('Error during getToken: $e');
      return Error('An error occurred during getToken: ${e.toString()}');
    }
  }

  Future<Resource<AuthTokenModel>> refreshToken(String refreshToken) async {
    try {
      print('Attempting to refresh token with access token: $refreshToken');

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
      print('Error during refreshToken: $e');
      return Error('An error occurred during refreshToken: ${e.toString()}');
    }
  }
}
