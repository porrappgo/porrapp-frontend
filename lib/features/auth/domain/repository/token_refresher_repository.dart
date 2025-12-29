import 'package:porrapp_frontend/core/util/resource.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

abstract class TokenRefresherRepository {
  Future<Resource<AuthTokenModel>> getToken(String email, String password);

  Future<Resource<String>?> refreshAccessToken();

  Future<Resource<AuthModel>> registerUser(
    String email,
    String name,
    String password,
  );
}
