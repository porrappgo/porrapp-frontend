import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:porrapp_frontend/core/util/util.dart';

class RegisterState extends Equatable {
  final BlocFormItem name;
  final BlocFormItem email;
  final BlocFormItem password;
  final BlocFormItem confirmPassword;
  final bool isLoadingRegistration;

  final GlobalKey<FormState>? formKey;
  final Resource<void>? registrationResource;

  const RegisterState({
    this.name = const BlocFormItem(error: 'Write your name'),
    this.email = const BlocFormItem(error: 'Write your email'),
    this.password = const BlocFormItem(error: 'Write your password'),
    this.confirmPassword = const BlocFormItem(error: 'Confirm your password'),
    this.formKey,
    this.registrationResource,
    this.isLoadingRegistration = false,
  });

  RegisterState copyWith({
    BlocFormItem? name,
    BlocFormItem? email,
    BlocFormItem? password,
    BlocFormItem? confirmPassword,
    GlobalKey<FormState>? formKey,
    Resource<void>? registrationResource,
    bool isLoadingRegistration = false,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      formKey: formKey ?? this.formKey,
      registrationResource: registrationResource ?? this.registrationResource,
      isLoadingRegistration: isLoadingRegistration,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    confirmPassword,
    formKey,
    registrationResource,
    isLoadingRegistration,
  ];
}
