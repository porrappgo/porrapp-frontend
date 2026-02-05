import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/core/injection.dart';

import 'package:porrapp_frontend/features/auth/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/auth/presentation/bloc/bloc.dart';
import 'package:porrapp_frontend/features/prediction/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/bloc/room_bloc.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/bloc/rooms_bloc.dart';
import 'package:porrapp_frontend/features/splash/presentation/bloc/splash_bloc.dart';

/// Returns a list of [BlocProvider]s used throughout the application.
List<BlocProvider> blocProviders() => [
  // SplashBloc provider
  BlocProvider<SplashBloc>(
    create: (context) =>
        SplashBloc(locator<AuthUseCases>())..add(LoadSplashEvent()),
  ),

  // AuthBloc provider
  BlocProvider<AuthBloc>(
    create: (context) => AuthBloc(locator<AuthUseCases>()),
  ),
  BlocProvider<RegisterBloc>(
    create: (context) => RegisterBloc(locator<AuthUseCases>()),
  ),

  BlocProvider<RoomsBloc>(
    create: (context) =>
        RoomsBloc(locator<PredictionUseCases>(), locator<AuthUseCases>()),
  ),
  BlocProvider<RoomBloc>(
    create: (context) => RoomBloc(locator<PredictionUseCases>()),
  ),
];
