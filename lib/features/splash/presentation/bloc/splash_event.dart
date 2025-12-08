import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object?> get props => [];
}

class SplashIsLoggedInEvent extends SplashEvent {
  const SplashIsLoggedInEvent();

  @override
  List<Object?> get props => [];
}
