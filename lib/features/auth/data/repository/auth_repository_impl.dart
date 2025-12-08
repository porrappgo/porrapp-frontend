import 'package:porrapp_frontend/core/util/resource.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';
import 'package:porrapp_frontend/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl();

  @override
  Future<Resource<TokenResponse>> getToken(String account, String phone) {
    // TODO: implement getToken
    throw UnimplementedError();
  }

  @override
  Future<Resource<AuthResponse>> login() {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUserSession(String account, String phone, String token) {
    // TODO: implement saveUserSession
    throw UnimplementedError();
  }
}
