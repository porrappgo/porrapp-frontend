import 'package:dio/dio.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<Resource<AuthTokenModel>> getToken(
    String email,
    String password,
  ) async {
    try {
      print(
        'Attempting to get token for email: $email and password: $password',
      );

      final response = await _dio.post(
        '/user/token/',
        data: {"email": email, "password": password},
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

  Future<Resource<AuthModel>> login(String token) async {
    try {
      final response = await _dio.get(
        '/user/me/',
        options: Options(headers: {"Authorization": "Token $token"}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthModel authResponse = AuthModel.fromJson(response.data);
        return Success<AuthModel>(authResponse);
      } else {
        return Error(response.data);
      }
    } catch (e) {
      // Handle error
      print('Error during login: $e');
      return Error('An error occurred during login: ${e.toString()}');
    }
  }
}
