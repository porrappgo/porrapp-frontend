import 'package:go_router/go_router.dart';
import 'package:porrapp_frontend/features/auth/presentation/auth_page.dart';
import 'package:porrapp_frontend/features/splash/presentation/splash_page.dart';
import 'package:porrapp_frontend/websocketpage.dart';

final appRouter = GoRouter(
  initialLocation: '/${SplashPage.routeName}',
  routes: [
    GoRoute(
      name: SplashPage.routeName,
      path: '/${SplashPage.routeName}',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      name: AuthPage.routeName,
      path: '/${AuthPage.routeName}',
      builder: (context, state) => const AuthPage(),
    ),
    GoRoute(
      name: WebSocketTestPage.routeName,
      path: '/${WebSocketTestPage.routeName}',
      builder: (context, state) => const WebSocketTestPage(),
    ),
  ],
);
