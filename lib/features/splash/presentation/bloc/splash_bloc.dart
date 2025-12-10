import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';
import 'package:porrapp_frontend/features/splash/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/splash/presentation/bloc/bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashUsecases isLoggedInUseCase;

  SplashBloc(this.isLoggedInUseCase) : super(SplashState()) {
    on<SplashIsLoggedInEvent>(_onSplashIsLoggedInEvent);
  }

  void _onSplashIsLoggedInEvent(
    SplashIsLoggedInEvent event,
    Emitter<SplashState> emit,
  ) async {
    try {
      print("SplashBloc: SplashIsLoggedInEvent triggered");
      emit(state.copyWith(isLoading: true));
      Resource<AuthModel> isLoggedIn = await isLoggedInUseCase.isLoggedIn.run();
      print(
        "SplashBloc: isLoggedIn: $isLoggedIn and type: ${isLoggedIn is Success}",
      );
      emit(state.copyWith(isLoggedIn: isLoggedIn is Success, isLoading: false));
    } catch (e) {
      print("SplashBloc: Error in _onSplashIsLoggedInEvent: $e");
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
