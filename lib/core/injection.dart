import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:porrapp_frontend/core/env/env.dart';
import 'package:porrapp_frontend/core/secure/secure_storage.dart';
import 'package:porrapp_frontend/features/auth/data/datasource/remote/auth_service.dart';
import 'package:porrapp_frontend/features/auth/data/repository/auth_repository_impl.dart';
import 'package:porrapp_frontend/features/auth/domain/repository/auth_repository.dart';
import 'package:porrapp_frontend/features/auth/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/competitions/data/datasource/remote/competition_service.dart';
import 'package:porrapp_frontend/features/competitions/data/repository/competition_repository_impl.dart';
import 'package:porrapp_frontend/features/competitions/domain/repository/competition_repository.dart';
import 'package:porrapp_frontend/features/competitions/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/prediction/data/datasource/remote/prediction_service.dart';
import 'package:porrapp_frontend/features/prediction/data/repository/prediction_repository_impl.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';
import 'package:porrapp_frontend/features/prediction/domain/usecases/usecases.dart';
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

  // Secure Storage
  locator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  locator.registerLazySingleton<ISecureStorageService>(
    () => SecureStorage(locator<FlutterSecureStorage>()),
  );

  // Services
  locator.registerLazySingleton<AuthService>(() => AuthService(locator()));
  locator.registerLazySingleton<CompetitionService>(
    () => CompetitionService(locator()),
  );
  locator.registerLazySingleton<PredictionService>(
    () => PredictionService(locator()),
  );

  // Repositories
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      locator<AuthService>(),
      locator<ISecureStorageService>(),
    ),
  );
  locator.registerLazySingleton<CompetitionRepository>(
    () => CompetitionRepositoryImpl(
      locator<CompetitionService>(),
      locator<ISecureStorageService>(),
    ),
  );
  locator.registerLazySingleton<PredictionRepository>(
    () => PredictionRepositoryImpl(
      locator<PredictionService>(),
      locator<ISecureStorageService>(),
    ),
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
  locator.registerLazySingleton<PredictionUseCases>(
    () => PredictionUseCases(
      createRoomUseCase: CreateRoomUseCase(locator()),
      listRoomsUsecase: ListRoomsUsecase(locator()),
    ),
  );

  locator.registerLazySingleton<SplashUsecases>(
    () => SplashUsecases(isLoggedIn: IsLoggedInUsecase(locator())),
  );

  locator.registerLazySingleton<CompetitionUsecases>(
    () => CompetitionUsecases(
      getCompetitions: GetCompetitionsUseCase(locator()),
      getGroupsStandings: GetGroupsStandingsUseCase(locator()),
      getGroups: GetGroupsUseCase(locator()),
      getTeams: GetTeamsUseCase(locator()),
      getMatches: GetMatchesUseCase(locator()),
    ),
  );
}
