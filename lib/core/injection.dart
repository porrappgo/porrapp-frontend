import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'package:porrapp_frontend/core/env/env.dart';
import 'package:porrapp_frontend/features/competitions/domain/usecases/usecases.dart';

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

  // Use Cases
  locator.registerLazySingleton<CompetitionUsecases>(
    () =>
        CompetitionUsecases(getCompetitions: GetCompetitionsUseCase(locator())),
  );
}
