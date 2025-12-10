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
  Future<Resource<AuthTokenModel>> getToken(String email, String phone) async {
    /// Fetch user data
    return await _authService.getToken(email, phone);
  }

  @override
  Future<Resource<AuthModel>> login() async {
    var token = await _secureStorage.read(SecureStorageConstants.token);
    print('Retrieved token from secure storage in check login: $token');
    if (token == null) {
      return Error('No token found');
    }

    /// Check network connectivity
    /// Fetch user data
    return await _authService.login(token);
  }

  @override
  Future<bool> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUserSession(String email, String token) async {
    await Future.wait([_saveUserInSecureStorage(email, token)]);
    print('User session saved successfully.');
    return true;
  }

  /// Save user data in secure storage.
  Future<void> _saveUserInSecureStorage(String email, String token) async {
    await Future.wait([
      // Save user data in secure storage.
      _secureStorage.write(SecureStorageConstants.email, email),
      _secureStorage.write(SecureStorageConstants.token, token),

      /// Save user data in local database.
      //_saveUserInLocal(email, phone),
    ]);
  }
}
