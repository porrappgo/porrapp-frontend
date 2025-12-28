import 'package:porrapp_frontend/features/auth/domain/repository/auth_repository.dart';

class SaveUserUsecase {
  AuthRepository repository;

  SaveUserUsecase(this.repository);

  run(String email, String access, String? refresh) async {
    return await repository.saveUserSession(email, access, refresh);
  }
}
