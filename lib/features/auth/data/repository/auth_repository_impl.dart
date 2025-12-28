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
  Future<Resource<bool>> logout() async {
    try {
      await _secureStorage.deleteAll();
      print('User logged out and secure storage cleared.');
      print('Validating logout operation: secure storage should be empty.');
      var email = await _secureStorage.read(SecureStorageConstants.email);
      var access = await _secureStorage.read(
        SecureStorageConstants.tokenAccess,
      );
      var refresh = await _secureStorage.read(
        SecureStorageConstants.tokenRefresh,
      );
      print(
        'Post-logout secure storage values: email=$email, access=$access, refresh=$refresh',
      );
      return Success(true);
    } catch (e) {
      print('Error during logout: $e');
      return Error('Failed to logout');
    }
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
