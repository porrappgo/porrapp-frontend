part of 'setting_bloc.dart';

sealed class SettingState extends Equatable {
  const SettingState();

  @override
  List<Object> get props => [];
}

final class SettingInitial extends SettingState {}

final class SettingLoading extends SettingState {}

final class SettingError extends SettingState {
  final String message;

  const SettingError(this.message);

  @override
  List<Object> get props => [message];
}

final class LogoutLoading extends SettingState {}

final class LogoutSuccess extends SettingState {}

final class LogoutError extends SettingState {
  final String message;

  const LogoutError(this.message);

  @override
  List<Object> get props => [message];
}
