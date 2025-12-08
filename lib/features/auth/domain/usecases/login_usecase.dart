import 'package:porrapp_frontend/features/auth/domain/repository/auth_repository.dart';

class LoginUseCase {
  AuthRepository repository;

  LoginUseCase(this.repository);

  run() async {
    return await repository.login();
  }
}
