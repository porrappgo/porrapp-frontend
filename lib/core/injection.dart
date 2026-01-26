import 'package:dio/dio.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:porrapp_frontend/core/env/env.dart';
import 'package:porrapp_frontend/core/secure/secure_storage.dart';
import 'package:porrapp_frontend/features/auth/data/datasource/remote/auth_interceptor.dart';
import 'package:porrapp_frontend/features/auth/data/datasource/remote/auth_service.dart';
import 'package:porrapp_frontend/features/auth/data/datasource/remote/token_service.dart';
import 'package:porrapp_frontend/features/auth/data/repository/auth_repository_impl.dart';
import 'package:porrapp_frontend/features/auth/data/repository/token_refresher_repository_impl.dart';
import 'package:porrapp_frontend/features/auth/domain/repository/auth_repository.dart';
import 'package:porrapp_frontend/features/auth/domain/repository/token_refresher_repository.dart';
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
  // ───────────────────────────────
  // 🔊 Logs
  // ───────────────────────────────
  await FlutterLogs.initLogs(
    directoryStructure: DirectoryStructure.FOR_DATE,
    timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
    logFileExtension: LogFileExtension.LOG,
  );

  // ───────────────────────────────
  // 🔐 Secure Storage
  // ───────────────────────────────
  locator.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );

  locator.registerLazySingleton<ISecureStorageService>(
    () => SecureStorage(locator<FlutterSecureStorage>()),
  );

  // ───────────────────────────────
  // 🌐 Dio without interceptor (auth)
  // ───────────────────────────────
  locator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: envConfig.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    ),
    instanceName: 'authDio',
  );

  // ───────────────────────────────
  // 🌐 Dio with interceptor (API)
  // ───────────────────────────────
  locator.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: envConfig.baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );

    dio.interceptors.add(
      AuthInterceptor(
        locator<Dio>(instanceName: 'authDio'),
        locator<ISecureStorageService>(),
        locator<TokenRefresherRepository>(),
      ),
    );

    return dio;
  }, instanceName: 'apiDio');

  // ───────────────────────────────
  // 🔌 Services
  // ───────────────────────────────
  locator.registerLazySingleton<TokenService>(
    () => TokenService(locator<Dio>(instanceName: 'authDio')),
  );

  locator.registerLazySingleton<AuthService>(
    () => AuthService(locator<Dio>(instanceName: 'apiDio')),
  );

  locator.registerLazySingleton<CompetitionService>(
    () => CompetitionService(locator<Dio>(instanceName: 'apiDio')),
  );

  locator.registerLazySingleton<PredictionService>(
    () => PredictionService(locator<Dio>(instanceName: 'apiDio')),
  );

  // ───────────────────────────────
  // 📦 Repositories
  // ───────────────────────────────
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      locator<AuthService>(),
      locator<ISecureStorageService>(),
    ),
  );

  locator.registerLazySingleton<TokenRefresherRepository>(
    () => TokenRefresherRepositoryImpl(
      locator<TokenService>(),
      locator<ISecureStorageService>(),
    ),
  );

  locator.registerLazySingleton<CompetitionRepository>(
    () => CompetitionRepositoryImpl(locator<CompetitionService>()),
  );

  locator.registerLazySingleton<PredictionRepository>(
    () => PredictionRepositoryImpl(locator<PredictionService>()),
  );

  // ───────────────────────────────
  // 🧠 Use Cases
  // ───────────────────────────────
  locator.registerLazySingleton<AuthUseCases>(
    () => AuthUseCases(
      login: LoginUseCase(locator()),
      getToken: GetTokenUseCase(locator()),
      saveUserSession: SaveUserUsecase(locator()),
      logout: LogoutUseCase(locator()),
      register: RegisterUseCase(locator()),
    ),
  );

  locator.registerLazySingleton<PredictionUseCases>(
    () => PredictionUseCases(
      createRoomUseCase: CreateRoomUseCase(locator()),
      listRoomsUsecase: ListRoomsUsecase(locator()),
      roomsWithCompetitionsUseCases: RoomsWithCompetitionsUseCases(
        locator(),
        locator(),
      ),
      getPredictionsForRoomUsecase: GetPredictionsForRoomUsecase(locator()),
      updatePredictionsUseCase: UpdatePredictionsUseCase(locator()),
      joinRoomUseCase: JoinRoomUseCase(locator()),
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
