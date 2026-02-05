import 'package:dio/dio.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

class AuthService {
  static const String tag = 'AuthService';
  final Dio _dio;

  AuthService(this._dio);

  Future<AuthModel> login() async {
    FlutterLogs.logInfo(tag, "login", "Initiating login request to /user/me/");
    final response = await _dio.get('/user/me/');

    if (response.statusCode == 200) {
      FlutterLogs.logInfo(
        tag,
        "login",
        "Received response with status code ${response.statusCode}",
      );
      AuthModel authResponse = AuthModel.fromJson(response.data);
      return authResponse;
    } else {
      FlutterLogs.logError(
        tag,
        "login",
        "Login failed with status code ${response.statusCode}",
      );
      throw ServerException();
    }
  }
}
