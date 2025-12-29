import 'package:porrapp_frontend/features/auth/domain/repository/token_refresher_repository.dart';

class GetTokenUseCase {
  TokenRefresherRepository repository;

  GetTokenUseCase(this.repository);

  run(String email, String password) async {
    return await repository.getToken(email, password);
  }
}
