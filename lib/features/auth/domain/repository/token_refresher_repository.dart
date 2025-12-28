import 'package:porrapp_frontend/core/util/resource.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

abstract class TokenRefresherRepository {
  Future<Resource<AuthTokenModel>> getToken(String email, String phone);

  Future<Resource<String>?> refreshAccessToken();
}
