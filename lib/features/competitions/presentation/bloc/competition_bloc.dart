import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/auth/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/competitions/domain/usecases/usecases.dart';
import 'package:porrapp_frontend/features/competitions/presentation/bloc/bloc.dart';

class CompetitionBloc extends Bloc<CompetitionEvent, CompetitionState> {
  final AuthUseCases authUseCases;
  final CompetitionUsecases competitionUsecases;

  CompetitionBloc(this.authUseCases, this.competitionUsecases)
    : super(const CompetitionState()) {
    on<LoadCompetitionsEvent>(_onLoadCompetitionsEvent);
    on<LoadMatchesEvent>(_onLoadMatchesEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  void _onLoadCompetitionsEvent(
    LoadCompetitionsEvent event,
    Emitter<CompetitionState> emit,
  ) async {
    try {
      print('Loading leagues and groups...');
      emit(state.copyWith(leagues: Loading()));
      final competitions = await competitionUsecases.getCompetitions.run();
      emit(state.copyWith(leagues: competitions));

      if (competitions is Success) {
        for (var competition in competitions.data) {
          print('Fetching groups for competition ID: ${competition.id}');

          // Fetch groups for each competition
          final groups = await competitionUsecases.getGroups.run(
            competition.id,
          );

          // Fetch group standings and associated teams
          final groupsIds = groups is Success<List<GroupModel>>
              ? groups.data.map((g) => g.id).toList()
              : List<int>.empty();

          print('Group IDs to fetch standings for: $groupsIds');

          // Run both operations in parallel for better performance
          final results = await Future.wait([
            _loadGroupStandings(groupsIds),
            _loadTeams(),
          ]);

          final groupStandings = results[0];
          final teams = results[1];

          emit(
            state.copyWith(
              leagues: competitions,
              groups: groups,
              groupStandings: groupStandings,
              teams: teams,
            ),
          );
        }
      }
    } catch (e) {
      print('Error loading leagues and groups: $e');
      emit(state.copyWith(leagues: Error('Failed to load competitions')));
    }
  }

  void _onLoadMatchesEvent(
    LoadMatchesEvent event,
    Emitter<CompetitionState> emit,
  ) async {
    try {
      print('Loading matches...');
      emit(state.copyWith(matches: Loading()));
      final matches = await competitionUsecases.getMatches.run();
      emit(state.copyWith(matches: matches));
    } catch (e) {
      print('Error loading matches: $e');
      emit(state.copyWith(matches: Error('Failed to load matches')));
    }
  }

  Future<Resource<bool>> _onLogoutEvent(
    LogoutEvent event,
    Emitter<CompetitionState> emit,
  ) async {
    try {
      print('Logging out user...');
      emit(state.copyWith(logout: Loading()));
      final logoutResult = await authUseCases.logout.run();
      emit(
        state.copyWith(
          logout: logoutResult,
          leagues: null,
          groups: null,
          groupStandings: null,
          teams: null,
          matches: null,
        ),
      );
      return logoutResult;
    } catch (e) {
      print('Error during logout: $e');
      emit(state.copyWith(logout: Error('Failed to logout')));
      return Error('Failed to logout');
    }
  }

  Future<Resource<List<GroupStandingModel>>> _loadGroupStandings(
    List<int> groupIds,
  ) async {
    try {
      print('Loading group standings for group IDs: $groupIds');
      return await competitionUsecases.getGroupsStandings.run(groupIds);
    } catch (e) {
      print('Error loading group standings: $e');
      return Error('Failed to load group standings');
    }
  }

  Future<Resource<List<TeamModel>>> _loadTeams() async {
    try {
      print('Loading teams...');
      return await competitionUsecases.getTeams.run();
    } catch (e) {
      print('Error loading teams: $e');
      return Error('Failed to load teams');
    }
  }
}
