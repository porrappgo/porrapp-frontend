import 'package:porrapp_frontend/features/competitions/domain/usecases/usecases.dart';

class CompetitionUsecases {
  GetCompetitionsUseCase getCompetitions;
  GetGroupsStandingsUseCase getGroupsStandings;
  GetGroupsUseCase getGroups;
  GetTeamsUseCase getTeams;
  GetMatchesUseCase getMatches;

  CompetitionUsecases({
    required this.getCompetitions,
    required this.getGroupsStandings,
    required this.getGroups,
    required this.getTeams,
    required this.getMatches,
  });
}
