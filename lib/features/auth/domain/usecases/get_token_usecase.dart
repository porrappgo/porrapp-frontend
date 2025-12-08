import 'package:porrapp_frontend/features/auth/domain/repository/auth_repository.dart';

class GetTokenUseCase {
  AuthRepository repository;

  GetTokenUseCase(this.repository);

  run(String account, String phone) async {
    return await repository.getToken(account, phone);
  }
}
