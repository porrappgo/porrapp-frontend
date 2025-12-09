import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:porrapp_frontend/core/env/env.dart';
import 'package:porrapp_frontend/features/auth/data/datasource/remote/auth_service.dart';
import 'package:porrapp_frontend/features/auth/data/repository/auth_repository_impl.dart';
import 'package:porrapp_frontend/features/auth/domain/repository/auth_repository.dart';
import 'package:porrapp_frontend/features/auth/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/competitions/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/splash/domain/usecases/usecases.dart';

final locator = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies(Env envConfig) async {
  // Dio
  locator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: envConfig.baseUrl,
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 3),
      ),
    ),
  );
  // Services
  locator.registerLazySingleton<AuthService>(() => AuthService(locator()));

  // Repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(locator<AuthService>()),
  );

  // Use Cases
  locator.registerLazySingleton<AuthUseCases>(
    () => AuthUseCases(
      login: LoginUseCase(locator()),
      getToken: GetTokenUseCase(locator()),
      saveUserSession: SaveUserUsecase(locator()),
      logout: LogoutUseCase(locator()),
    ),
  );

  locator.registerLazySingleton<SplashUsecases>(
    () => SplashUsecases(isLoggedIn: IsLoggedInUsecase(locator())),
  );

  locator.registerLazySingleton<CompetitionUsecases>(
    () =>
        CompetitionUsecases(getCompetitions: GetCompetitionsUseCase(locator())),
  );
}
