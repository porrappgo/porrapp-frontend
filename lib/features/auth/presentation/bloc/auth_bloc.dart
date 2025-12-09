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
    on<AuthResetResource>(_onAuthResetResource);
    on<AuthSaveUserSession>(_onAuthSaveUserSession);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
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

  void _onAuthResetResource(AuthResetResource event, Emitter<AuthState> emit) {
    print('AuthBloc - Resetting resource state');
    emit(state.copyWith(response: Initial(), formKey: formKey));
  }

  void _onAuthSaveUserSession(
    AuthSaveUserSession event,
    Emitter<AuthState> emit,
  ) {}

  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) {
    print('AuthBloc - Email changed: ${event.email.value}');
    emit(
      state.copyWith(
        email: BlocFormItem(
          value: event.email.value,
          error: event.email.value.isNotEmpty ? null : 'Enter a valid email',
        ),
        formKey: formKey,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) {
    print('AuthBloc - Password changed: ${event.password.value}');
    emit(
      state.copyWith(
        password: BlocFormItem(
          value: event.password.value,
          error: event.password.value.length >= 6 ? null : 'Password too short',
        ),
        formKey: formKey,
      ),
    );
  }

  void _onAuthSubmitted(AuthSubmitted event, Emitter<AuthState> emit) async {
    try {
      print('AuthBloc - AuthSubmitted event triggered');
      emit(state.copyWith(response: Loading(), formKey: formKey));

      print(
        'Submitting login with email: ${state.email.value} and password: ${state.password.value}',
      );

      Resource<AuthTokenModel> response = await authUseCases.getToken.run(
        state.email.value,
        state.password.value,
      );

      print('AuthBloc - Received response: $response');
      emit(state.copyWith(response: response, formKey: formKey));
    } catch (e) {
      print('AuthBloc - Error during AuthSubmitted: $e');
      emit(
        state.copyWith(
          response: Error('An unexpected error occurred'),
          formKey: formKey,
        ),
      );
    }
  }

  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {}
}
