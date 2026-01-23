import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    final defaultImage = Theme.of(context).brightness == Brightness.dark
        ? AssetImage('assets/images/light_soccer_placeholder.png')
        : AssetImage('assets/images/soccer_placeholder.png');

    // Page content with loading indicator or branding.
    // Check token validity and navigate accordingly.
    return Scaffold(
      body: Center(
        child: BlocListener<SplashBloc, SplashState>(
          listener: (context, state) {
            if (state is SplashInitial || state is SplashError) {
              context.go('/${LoginPage.routeName}');
            } else if (state is SplashLoaded) {
              context.go('/${RoomsPage.routeName}');
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInImage(
                width: 90,
                height: 90,
                placeholder: defaultImage,
                image: defaultImage,
              ),
              const SizedBox(height: 30),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
