import 'package:dartz/dartz.dart';
import 'package:porrapp_frontend/core/util/util.dart';

import 'package:porrapp_frontend/features/competitions/data/datasource/remote/competition_service.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/competitions/domain/repository/competition_repository.dart';

class CompetitionRepositoryImpl extends CompetitionRepository {
  final CompetitionService _competitionService;

  CompetitionRepositoryImpl(this._competitionService);

  @override
  Future<Either<Failure, List<CompetitionModel>>> getAll() async {
    /**
     * Retrieve the token from secure storage
     * and fetch all competitions using the competition service.
     */
    try {
      final competitions = await _competitionService.getAll();
      return Right(competitions);
    } on ServerException {
      return Left(ServerFailure(''));
    }
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
