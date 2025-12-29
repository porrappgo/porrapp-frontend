import 'package:equatable/equatable.dart';
import 'package:porrapp_frontend/core/util/util.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterFormInitialEvent extends RegisterEvent {
  const RegisterFormInitialEvent();

  @override
  List<Object> get props => [];
}

class RegisterFormResetEvent extends RegisterEvent {
  const RegisterFormResetEvent();

  @override
  List<Object> get props => [];
}

class NameChangedEvent extends RegisterEvent {
  final BlocFormItem name;

  const NameChangedEvent({required this.name});

  @override
  List<Object> get props => [name];
}

class EmailChangedEvent extends RegisterEvent {
  final BlocFormItem email;

  const EmailChangedEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class PasswordChangedEvent extends RegisterEvent {
  final BlocFormItem password;

  const PasswordChangedEvent({required this.password});

  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChangedEvent extends RegisterEvent {
  final BlocFormItem confirmPassword;

  const ConfirmPasswordChangedEvent({required this.confirmPassword});

  @override
  List<Object> get props => [confirmPassword];
}

class RegisterFormSubmittedEvent extends RegisterEvent {
  const RegisterFormSubmittedEvent();
}
