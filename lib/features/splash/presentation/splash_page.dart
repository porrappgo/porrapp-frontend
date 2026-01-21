import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:go_router/go_router.dart';
import 'package:porrapp_frontend/features/auth/presentation/login_page.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/rooms_page.dart';
import 'package:porrapp_frontend/features/splash/presentation/bloc/splash_bloc.dart';

class SplashPage extends StatelessWidget {
  static const String tag = "SplashPage";
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
            if (state is SplashInitial) {
              context.go('/${LoginPage.routeName}');
            } else if (state is SplashLoaded) {
              context.go('/${RoomsPage.routeName}');
            }
          },
          child: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              if (state is SplashLoading) {
                return const CircularProgressIndicator();
              }

              return const Text('Welcome to PorrApp!');
            },
          ),
        ),
      ),
    );
  }
}
