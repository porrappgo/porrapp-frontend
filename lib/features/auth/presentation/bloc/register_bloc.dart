import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';
import 'package:porrapp_frontend/features/auth/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/auth/presentation/bloc/bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  AuthUseCases authUseCases;

  RegisterBloc(this.authUseCases) : super(RegisterState()) {
    on<RegisterFormInitialEvent>(_onRegisterFormInitialEvent);
    on<RegisterFormResetEvent>(_onRegisterFormResetEvent);
    on<NameChangedEvent>(_onNameChangedEvent);
    on<EmailChangedEvent>(_onEmailChangedEvent);
    on<PasswordChangedEvent>(_onPasswordChangedEvent);
    on<ConfirmPasswordChangedEvent>(_onConfirmPasswordChangedEvent);
    on<RegisterFormSubmittedEvent>(_onRegisterFormSubmittedEvent);
  }

  final formKey = GlobalKey<FormState>();

  void _onRegisterFormInitialEvent(
    RegisterFormInitialEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(registrationResource: Initial(), formKey: formKey));
  }

  void _onRegisterFormResetEvent(
    RegisterFormResetEvent event,
    Emitter<RegisterState> emit,
  ) {
    state.formKey?.currentState?.reset();
    emit(RegisterState(registrationResource: null, formKey: formKey));
  }

  void _onNameChangedEvent(
    NameChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        name: BlocFormItem(
          value: event.name.value,
          error: FormatValidator.isValidName(event.name.value),
        ),
        formKey: formKey,
      ),
    );
  }

  void _onEmailChangedEvent(
    EmailChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
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

  void _onPasswordChangedEvent(
    PasswordChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        password: BlocFormItem(
          value: event.password.value,
          error: FormatValidator.isValidPasswordReturnErrorMessage(
            event.password.value,
          ),
        ),
        formKey: formKey,
      ),
    );
  }

  void _onConfirmPasswordChangedEvent(
    ConfirmPasswordChangedEvent event,
    Emitter<RegisterState> emit,
  ) {
    emit(
      state.copyWith(
        confirmPassword: BlocFormItem(
          value: event.confirmPassword.value,
          error: FormatValidator.doPasswordsMatch(
            state.password.value,
            event.confirmPassword.value,
          ),
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onRegisterFormSubmittedEvent(
    RegisterFormSubmittedEvent event,
    Emitter<RegisterState> emit,
  ) async {
    print('RegisterBloc - RegisterFormSubmittedEvent triggered');
    try {
      emit(
        state.copyWith(
          registrationResource: Loading(),
          isLoadingRegistration: true,
          formKey: formKey,
        ),
      );
      Resource<AuthModel> response = await authUseCases.register.run(
        state.email.value,
        state.name.value,
        state.password.value,
      );
      print('RegisterBloc - Received response: $response');

      if (response is Error) {
        emit(
          state.copyWith(
            registrationResource: response,
            isLoadingRegistration: false,
            formKey: formKey,
          ),
        );
        return;
      }
      Resource<AuthTokenModel> tokenResponse = await authUseCases.getToken.run(
        state.email.value,
        state.password.value,
      );

      Success<AuthTokenModel> tokens = tokenResponse as Success<AuthTokenModel>;

      print(
        'RegisterBloc - Retrieved tokens: Access - ${tokens.data.access}, Refresh - ${tokens.data.refresh}',
      );
      await authUseCases.saveUserSession.run(
        state.email.value,
        tokens.data.access,
        tokens.data.refresh,
      );

      emit(
        state.copyWith(
          registrationResource: response,
          isLoadingRegistration: false,
          formKey: formKey,
        ),
      );
    } catch (e) {
      print('RegisterBloc - Error during registration: $e');
      emit(
        state.copyWith(
          registrationResource: Error('An unexpected error occurred'),
          isLoadingRegistration: false,
          formKey: formKey,
        ),
      );
    }
  }
}
