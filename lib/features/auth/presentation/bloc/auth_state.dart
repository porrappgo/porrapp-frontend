import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

import 'package:porrapp_frontend/core/util/util.dart';

class AuthState extends Equatable {
  final BlocFormItem email;
  final BlocFormItem password;

  final Resource? response;
  final GlobalKey<FormState>? formKey;

  const AuthState({
    this.email = const BlocFormItem(error: 'Write your email'),
    this.password = const BlocFormItem(error: 'Write your password'),
    this.response,
    this.formKey,
  });

  AuthState copyWith({
    BlocFormItem? email,
    BlocFormItem? password,
    Resource? response,
    GlobalKey<FormState>? formKey,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      response: response ?? this.response,
      formKey: formKey ?? this.formKey,
    );
  }

  @override
  List<Object?> get props => [email, password, response, formKey];
}
