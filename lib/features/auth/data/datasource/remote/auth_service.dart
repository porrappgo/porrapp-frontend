import 'package:dio/dio.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

class AuthService {
  final Dio _dio;

  AuthService(this._dio);

  Future<Resource<AuthModel>> login() async {
    try {
      print('AuthService: Initiating login request to /user/me/');
      final response = await _dio.get('/user/me/');
      print(
        'AuthService: Received response with status code ${response.statusCode}',
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
