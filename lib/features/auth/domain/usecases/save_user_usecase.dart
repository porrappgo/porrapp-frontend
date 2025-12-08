import 'package:porrapp_frontend/features/auth/domain/repository/auth_repository.dart';

class SaveUserUsecase {
  AuthRepository repository;

  SaveUserUsecase(this.repository);

  run(String account, String phone, String token) async {
    return await repository.saveUserSession(account, phone, token);
  }
}
