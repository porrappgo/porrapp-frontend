import 'package:porrapp_frontend/features/auth/domain/usecases/usecases.dart';

class AuthUseCases {
  LoginUseCase login;
  GetTokenUseCase getToken;
  SaveUserUsecase saveUserSession;
  LogoutUseCase logout;
  RegisterUseCase register;

  AuthUseCases({
    required this.login,
    required this.getToken,
    required this.saveUserSession,
    required this.logout,
    required this.register,
  });
}
