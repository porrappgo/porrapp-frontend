import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

abstract class AuthRepository {
  Future<Resource<AuthResponse>> login();

  Future<bool> logout();

  Future<Resource<TokenResponse>> getToken(String account, String phone);

  Future<bool> saveUserSession(String account, String phone, String token);
}
