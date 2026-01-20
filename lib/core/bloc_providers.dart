import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/core/injection.dart';

import 'package:porrapp_frontend/features/auth/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/auth/presentation/bloc/bloc.dart';
import 'package:porrapp_frontend/features/competitions/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/competitions/presentation/bloc/competition_bloc.dart';
import 'package:porrapp_frontend/features/prediction/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/bloc/room_bloc.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/bloc/rooms_bloc.dart';
import 'package:porrapp_frontend/features/splash/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/splash/presentation/bloc/bloc.dart';

/// Returns a list of [BlocProvider]s used throughout the application.
List<BlocProvider> blocProviders() => [
  // SplashBloc provider
  BlocProvider<SplashBloc>(
    create: (context) =>
        SplashBloc(locator<SplashUsecases>())..add(SplashIsLoggedInEvent()),
  ),

  // AuthBloc provider
  BlocProvider<AuthBloc>(
    create: (context) => AuthBloc(locator<AuthUseCases>()),
  ),
  BlocProvider<RegisterBloc>(
    create: (context) => RegisterBloc(locator<AuthUseCases>()),
  ),

  // CompetitionBloc provider
  BlocProvider<CompetitionBloc>(
    create: (context) =>
        CompetitionBloc(locator<AuthUseCases>(), locator<CompetitionUsecases>())
          ..add(LoadCompetitionsEvent()),
  ),

  BlocProvider<RoomsBloc>(
    create: (context) =>
        RoomsBloc(locator<PredictionUseCases>(), locator<AuthUseCases>())
          ..add(LoadRoomsEvent()),
  ),
  BlocProvider<RoomBloc>(
    create: (context) => RoomBloc(locator<PredictionUseCases>()),
  ),
];
