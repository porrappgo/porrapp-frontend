import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:porrapp_frontend/features/auth/presentation/auth_page.dart';
import 'package:porrapp_frontend/features/splash/presentation/bloc/bloc.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = 'splash';

  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Page content with loading indicator or branding.
    // Check token validity and navigate accordingly.
    return Scaffold(
      body: Center(
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            final isLoading = state.isLoading;
            final isLoggedIn = state.isLoggedIn;
            final errorMessage = state.errorMessage;

            print(
              'SplashPage - isLoading: $isLoading, isLoggedIn: $isLoggedIn, errorMessage: $errorMessage',
            );

            if (!isLoading && !isLoggedIn) {
              context.go('/${AuthPage.routeName}');
            }
          },
          child: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const CircularProgressIndicator();
              } else if (state.errorMessage != null) {
                return Text('Error: ${state.errorMessage}');
              } else {
                return const Text('Welcome to PorrApp!');
              }
            },
          ),
        ),
      ),
    );
  }
}
