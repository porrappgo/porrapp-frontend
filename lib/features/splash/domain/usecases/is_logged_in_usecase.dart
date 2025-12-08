import 'package:porrapp_frontend/features/auth/domain/repository/auth_repository.dart';

class IsLoggedInUsecase {
  AuthRepository repository;

  IsLoggedInUsecase(this.repository);

  run() async {
    return await repository.login();
  }
}
