import 'package:go_router/go_router.dart';
import 'package:porrapp_frontend/features/auth/presentation/auth_page.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/competitions/presentation/competition_page.dart';
import 'package:porrapp_frontend/features/competitions/presentation/group_standings_page.dart';
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
      name: CompetitionPage.routeName,
      path: '/${CompetitionPage.routeName}',
      builder: (context, state) => const CompetitionPage(),
    ),
    GoRoute(
      name: WebSocketTestPage.routeName,
      path: '/${WebSocketTestPage.routeName}',
      builder: (context, state) => const WebSocketTestPage(),
    ),
    GoRoute(
      name: GroupStandingsPage.routeName,
      path: '/${GroupStandingsPage.routeName}',
      builder: (context, state) {
        final group = state.extra as List<GroupModel>;
        return GroupStandingsPage(group: group);
      },
    ),
  ],
);
