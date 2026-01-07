import 'package:porrapp_frontend/core/constants/constants.dart';
import 'package:porrapp_frontend/core/secure/secure_storage.dart';
import 'package:porrapp_frontend/core/util/resource.dart';
import 'package:porrapp_frontend/features/auth/data/datasource/remote/token_service.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';
import 'package:porrapp_frontend/features/auth/domain/repository/token_refresher_repository.dart';

class TokenRefresherRepositoryImpl implements TokenRefresherRepository {
  final TokenService _tokenService;
  final ISecureStorageService _secureStorage;

  TokenRefresherRepositoryImpl(this._tokenService, this._secureStorage);

  @override
  Future<Resource<String>> refreshAccessToken() async {
    final refresh = await _secureStorage.read(
      SecureStorageConstants.tokenRefresh,
    );

    print("TokenRefresherRepositoryImpl: refresh token: $refresh");

    if (refresh == null) return Error("No refresh token found");

    final response = await _tokenService.refreshToken(refresh);

    if (response is Success<AuthTokenModel>) {
      String tokenAccess = response.data.access;
      await _saveUpdateUserTokenInSecureStorage(tokenAccess);
      return Success(tokenAccess);
    }

    return Error("Failed to refresh token");
  }

  @override
  Future<Resource<AuthTokenModel>> getToken(
    String email,
    String password,
  ) async {
    return await _tokenService.getToken(email, password);
  }

  @override
  Future<Resource<AuthModel>> registerUser(
    String email,
    String name,
    String password,
  ) async {
    return await _tokenService.register(email, name, password);
  }

  /// Update user token in secure storage.
  Future<void> _saveUpdateUserTokenInSecureStorage(String tokenAccess) async {
    await Future.wait([
      _secureStorage.write(SecureStorageConstants.tokenAccess, tokenAccess),
    ]);

    final token = await _secureStorage.read(SecureStorageConstants.tokenAccess);
    final refresh = await _secureStorage.read(
      SecureStorageConstants.tokenRefresh,
    );
    print(
      "TokenRefresherRepositoryImpl: Updated tokenAccess: $token, tokenRefresh: $refresh",
    );
  }
}
