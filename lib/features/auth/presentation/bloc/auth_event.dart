import 'package:equatable/equatable.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthFormReset extends AuthEvent {
  const AuthFormReset();
}

class AuthResetResource extends AuthEvent {
  const AuthResetResource();
}

class AuthSaveUserSession extends AuthEvent {
  final AuthTokenModel response;

  const AuthSaveUserSession({required this.response});

  @override
  List<Object?> get props => [response];
}

class EmailChanged extends AuthEvent {
  final BlocFormItem email;

  const EmailChanged({required this.email});

  @override
  List<Object?> get props => [email];
}

class PasswordChanged extends AuthEvent {
  final BlocFormItem password;

  const PasswordChanged({required this.password});

  @override
  List<Object?> get props => [password];
}

class AuthSubmitted extends AuthEvent {
  const AuthSubmitted();
}
