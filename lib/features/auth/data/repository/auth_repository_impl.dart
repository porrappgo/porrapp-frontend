import 'package:porrapp_frontend/core/constants/constants.dart';
import 'package:porrapp_frontend/core/secure/secure_storage.dart';
import 'package:porrapp_frontend/core/util/resource.dart';
import 'package:porrapp_frontend/features/auth/data/datasource/remote/auth_service.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';
import 'package:porrapp_frontend/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthService _authService;
  final ISecureStorageService _secureStorage;

  AuthRepositoryImpl(this._authService, this._secureStorage);

  @override
  Future<Resource<AuthModel>> login() async {
    /// Fetch user data
    return await _authService.login();
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUserSession(
    String email,
    String access,
    String? refresh,
  ) async {
    await Future.wait([_saveUserTokenInSecureStorage(email, access, refresh)]);
    print('User session saved successfully.');
    return true;
  }

  /// Save user data in secure storage.
  Future<void> _saveUserTokenInSecureStorage(
    String email,
    String access,
    String? refresh,
  ) async {
    await Future.wait([
      _secureStorage.write(SecureStorageConstants.email, email),
      _secureStorage.write(SecureStorageConstants.tokenAccess, access),
      if (refresh != null)
        _secureStorage.write(SecureStorageConstants.tokenRefresh, refresh),

      /// Save user data in local database.
      //_saveUserInLocal(email, phone),
    ]);
  }
}
