import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_logs/flutter_logs.dart';

import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';
import 'package:porrapp_frontend/features/auth/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/auth/presentation/bloc/bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static const String tag = "AuthBloc";
  AuthUseCases authUseCases;

  AuthBloc(this.authUseCases) : super(AuthState()) {
    on<AuthFormReset>(_onAuthFormReset);
    on<AuthResetResource>(_onAuthResetResource);
    on<AuthSaveUserSession>(_onAuthSaveUserSession);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<AuthSubmitted>(_onAuthSubmitted);
  }

  final formKey = GlobalKey<FormState>();

  void _onAuthFormReset(AuthFormReset event, Emitter<AuthState> emit) {
    state.formKey?.currentState?.reset();
  }

  void _onAuthResetResource(AuthResetResource event, Emitter<AuthState> emit) {
    formKey.currentState?.reset();
    emit(state.copyWith(response: Initial(), formKey: formKey));
  }

  void _onAuthSaveUserSession(
    AuthSaveUserSession event,
    Emitter<AuthState> emit,
  ) async {
    var response = state.response as Success<AuthTokenModel>;

    FlutterLogs.logInfo(
      AuthBloc.tag,
      '_onAuthSaveUserSession',
      'Saving user session for email: ${state.email.value}',
    );
    await authUseCases.saveUserSession.run(
      state.email.value,
      response.data.access,
      response.data.refresh,
    );
  }

  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) {
    emit(
      state.copyWith(
        email: BlocFormItem(
          value: event.email.value,
          error: FormatValidator.isValidEmailReturnErrorMessage(
            event.email.value,
          ),
        ),
        formKey: formKey,
      ),
    );
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) {
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
      FlutterLogs.logInfo(
        AuthBloc.tag,
        'AuthSubmitted',
        'AuthSubmitted event triggered',
      );
      emit(state.copyWith(response: Loading(), formKey: formKey));
      Resource<AuthTokenModel> response = await authUseCases.getToken.run(
        state.email.value,
        state.password.value,
      );

      FlutterLogs.logInfo(
        AuthBloc.tag,
        'AuthSubmitted',
        'Received response: $response',
      );
      emit(state.copyWith(response: response, formKey: formKey));
    } catch (e) {
      FlutterLogs.logError(
        AuthBloc.tag,
        'AuthSubmitted',
        'Error during AuthSubmitted: $e',
      );
      emit(
        state.copyWith(
          response: Error('An unexpected error occurred'),
          formKey: formKey,
        ),
      );
    }
  }
}
