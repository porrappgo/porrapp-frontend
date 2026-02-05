import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/features/auth/domain/usecases/usecases.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  static const String tag = "SettingBloc";

  final AuthUseCases authUseCases;

  SettingBloc(this.authUseCases) : super(SettingInitial()) {
    on<LogoutAppEvent>(_onLogoutFromAppEvent);
  }

  void _onLogoutFromAppEvent(
    LogoutAppEvent event,
    Emitter<SettingState> emit,
  ) async {
    emit(LogoutLoading());

    try {
      await authUseCases.logout.run();
      emit(LogoutSuccess());
    } catch (e) {
      emit(LogoutError('Failed to logout. Please try again.'));
    }
  }
}
