import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/core/injection.dart';
import 'package:porrapp_frontend/features/splash/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/splash/presentation/bloc/bloc.dart';

/// Returns a list of [BlocProvider]s used throughout the application.
List<BlocProvider> blocProviders() => [
  // SplashBloc provider
  BlocProvider<SplashBloc>(
    create: (context) =>
        SplashBloc(locator<SplashUsecases>())..add(SplashIsLoggedInEvent()),
  ),
];
