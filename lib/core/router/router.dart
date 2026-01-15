import 'package:go_router/go_router.dart';
import 'package:porrapp_frontend/features/auth/presentation/auth_page.dart';
import 'package:porrapp_frontend/features/auth/presentation/login_page.dart';
import 'package:porrapp_frontend/features/auth/presentation/register_page.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/competitions/presentation/competition_page.dart';
import 'package:porrapp_frontend/features/competitions/presentation/group_standings_page.dart';
import 'package:porrapp_frontend/features/competitions/presentation/matches_page.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/presentation/room/room_page.dart';
import 'package:porrapp_frontend/features/prediction/presentation/rooms/rooms_page.dart';
import 'package:porrapp_frontend/features/splash/presentation/splash_page.dart';

final appRouter = GoRouter(
  initialLocation: '/${SplashPage.routeName}',
  routes: [
    GoRoute(
      name: SplashPage.routeName,
      path: '/${SplashPage.routeName}',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      name: LoginPage.routeName,
      path: '/${LoginPage.routeName}',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/${RegisterPage.routeName}',
      builder: (context, state) => const RegisterPage(),
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
      name: GroupStandingsPage.routeName,
      path: '/${GroupStandingsPage.routeName}',
      builder: (context, state) {
        final competitions = state.extra as CompetitionsModel;
        return GroupStandingsPage(competitions: competitions);
      },
    ),
    GoRoute(
      name: MatchesPage.routeName,
      path: '/${MatchesPage.routeName}',
      builder: (context, state) {
        final competitions = state.extra as CompetitionsModel;
        return MatchesPage(competitions: competitions);
      },
    ),
    GoRoute(
      path: '/${RoomsPage.routeName}',
      builder: (context, state) => const RoomsPage(),
    ),
    // Added to handle deep linking with room code.
    // https://dev.to/faidterence/flutter-deep-linking-create-links-that-actually-work-3l2b
    GoRoute(
      path: '/dsr/:code',
      builder: (context, state) {
        final code = state.pathParameters['code'];
        return RoomsPage(codeRoom: code);
      },
    ),
    GoRoute(
      name: RoomPage.routeName,
      path: '/${RoomPage.routeName}',
      builder: (context, state) {
        final room = state.extra as RoomModel;
        return RoomPage(
          roomId: room.id ?? 0,
          roomName: room.name,
          deeplink: room.deeplink,
        );
      },
    ),
  ],
);
