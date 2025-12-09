import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';
import 'package:porrapp_frontend/features/auth/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/auth/presentation/bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthUseCases authUseCases;

  AuthBloc(this.authUseCases) : super(AuthState()) {
    on<AuthInitialEvent>(_onAuthInitialEvent);
    on<AuthFormReset>(_onAuthFormReset);
    on<AuthSaveUserSession>(_onAuthSaveUserSession);
    on<AccountChanged>(_onAccountChanged);
    on<PhoneChanged>(_onPhoneChanged);
    on<AuthSubmitted>(_onAuthSubmitted);
    on<AuthLogout>(_onAuthLogout);
  }

  final formKey = GlobalKey<FormState>();

  void _onAuthInitialEvent(
    AuthInitialEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(response: LoadingPage(), formKey: formKey));
    Resource<AuthModel> response = await authUseCases.login.run();
    emit(state.copyWith(response: response, formKey: formKey));
  }

  void _onAuthFormReset(AuthFormReset event, Emitter<AuthState> emit) {
    state.formKey?.currentState?.reset();
  }

  void _onAuthSaveUserSession(
    AuthSaveUserSession event,
    Emitter<AuthState> emit,
  ) {}

  void _onAccountChanged(AccountChanged event, Emitter<AuthState> emit) {}

  void _onPhoneChanged(PhoneChanged event, Emitter<AuthState> emit) {}

  void _onAuthSubmitted(AuthSubmitted event, Emitter<AuthState> emit) async {}

  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {}
}
