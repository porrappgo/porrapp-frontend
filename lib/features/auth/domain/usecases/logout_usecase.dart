import 'package:porrapp_frontend/features/auth/domain/repository/auth_repository.dart';

class LogoutUseCase {
  AuthRepository repository;

  LogoutUseCase(this.repository);

  run() async {
    return await repository.logout();
  }
}
