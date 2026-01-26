import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_logs/flutter_logs.dart';

import 'package:porrapp_frontend/features/auth/domain/usecases/usecases.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  static const String tag = "SplashBloc";

  final AuthUseCases authUseCases;

  SplashBloc(this.authUseCases) : super(SplashInitial()) {
    on<LoadSplashEvent>(_onLoadSplashEvent);
  }

  void _onLoadSplashEvent(
    LoadSplashEvent event,
    Emitter<SplashState> emit,
  ) async {
    FlutterLogs.logInfo(tag, "_onLoadSplashEvent", "LoadSplashEvent triggered");
    emit(SplashLoading());

    final resource = await authUseCases.login.run();
    resource.fold(
      (failure) {
        FlutterLogs.logInfo(
          tag,
          "_onLoadSplashEvent",
          "Token invalid or not found, navigating to LoginPage",
        );
        emit(SplashError(failure.message));
      },
      (user) {
        FlutterLogs.logInfo(
          tag,
          "_onLoadSplashEvent",
          "Token valid for user ${user.name}, navigating to RoomsPage",
        );
        emit(SplashLoaded());
      },
    );
  }
}
