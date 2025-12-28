import 'package:porrapp_frontend/core/util/resource.dart';

import 'package:porrapp_frontend/features/competitions/data/datasource/remote/competition_service.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/competitions/domain/repository/competition_repository.dart';

class CompetitionRepositoryImpl extends CompetitionRepository {
  final CompetitionService _competitionService;

  CompetitionRepositoryImpl(this._competitionService);

  @override
  Future<Resource<List<CompetitionModel>>> getAll() async {
    /**
     * Retrieve the token from secure storage
     * and fetch all competitions using the competition service.
     */
    return await _competitionService.getAll();
  }

  @override
  Future<Resource<List<GroupModel>>> getGroupsByCompetitionId(
    int competitionId,
  ) async {
    return await _competitionService.getGroups(competitionId);
  }

  @override
  Future<Resource<List<GroupStandingModel>>> getGroupsStandingByGroupsIds(
    List<int> groupIds,
  ) async {
    print('Fetching group standings for group IDs: $groupIds');

    return await _competitionService.getGroupStandings(groupIds);
  }

  @override
  Future<Resource<List<TeamModel>>> getTeams() async {
    return await _competitionService.getTeams();
  }

  @override
  Future<Resource<List<MatchModel>>> getMatches() async {
    return await _competitionService.getMatches();
  }
}
