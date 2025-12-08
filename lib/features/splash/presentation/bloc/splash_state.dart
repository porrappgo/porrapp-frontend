import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  final bool isLoggedIn;
  final bool isLoading;
  final String? errorMessage;

  const SplashState({
    this.isLoggedIn = false,
    this.isLoading = false,
    this.errorMessage,
  });

  SplashState copyWith({
    bool? isLoggedIn,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SplashState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoggedIn, isLoading, errorMessage];
}
