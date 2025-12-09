import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

abstract class AuthRepository {
  Future<Resource<AuthModel>> login();

  Future<bool> logout();

  Future<Resource<AuthTokenModel>> getToken(String account, String phone);

  Future<bool> saveUserSession(String account, String phone, String token);
}
