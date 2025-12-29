import 'package:porrapp_frontend/features/auth/domain/repository/token_refresher_repository.dart';

class RegisterUseCase {
  TokenRefresherRepository repository;

  RegisterUseCase(this.repository);

  run(String email, String name, String password) async {
    return await repository.registerUser(email, name, password);
  }
}
