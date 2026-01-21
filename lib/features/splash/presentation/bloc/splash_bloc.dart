import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_logs/flutter_logs.dart';

import 'package:porrapp_frontend/core/util/resource.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';
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
    try {
      FlutterLogs.logInfo(
        tag,
        "_onLoadSplashEvent",
        "LoadSplashEvent triggered",
      );
      emit(SplashLoading());

      Resource<AuthModel> isLoggedIn = await authUseCases.login.run();
      FlutterLogs.logInfo(
        tag,
        "_onLoadSplashEvent",
        "SplashBloc: isLoggedIn: $isLoggedIn and type: ${isLoggedIn is Success}",
      );
      if (isLoggedIn is Success<AuthModel>) {
        emit(SplashLoaded());
      } else {
        emit(SplashInitial());
      }
    } catch (e) {
      FlutterLogs.logError(
        tag,
        "_onLoadSplashEvent",
        "Error in _onLoadSplashEvent: $e",
      );
      emit(SplashError('An error occurred during splash loading'));
    }
  }
}
