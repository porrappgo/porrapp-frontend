import 'package:porrapp_frontend/core/util/resource.dart';
import 'package:porrapp_frontend/features/auth/data/datasource/remote/auth_service.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';
import 'package:porrapp_frontend/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthService _authService;

  AuthRepositoryImpl(this._authService);

  @override
  Future<Resource<AuthTokenModel>> getToken(
    String account,
    String phone,
  ) async {
    /// Fetch user data
    return await _authService.getToken(account, phone);
  }

  @override
  Future<Resource<AuthModel>> login() {
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
