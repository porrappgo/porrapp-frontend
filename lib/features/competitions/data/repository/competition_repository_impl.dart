import 'package:porrapp_frontend/core/constants/constants.dart';
import 'package:porrapp_frontend/core/secure/secure_storage.dart';
import 'package:porrapp_frontend/core/util/resource.dart';

import 'package:porrapp_frontend/features/competitions/data/datasource/remote/competition_service.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/competition_model.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/group_model.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/group_standings_model.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/team_model.dart';
import 'package:porrapp_frontend/features/competitions/domain/repository/competition_repository.dart';

class CompetitionRepositoryImpl extends CompetitionRepository {
  final CompetitionService _competitionService;
  final ISecureStorageService _secureStorage;

  CompetitionRepositoryImpl(this._competitionService, this._secureStorage);

  @override
  Future<Resource<List<CompetitionModel>>> getAll() async {
    /**
     * Retrieve the token from secure storage
     * and fetch all competitions using the competition service.
     */
    var token = await _getToken();
    if (token == null) {
      return Error('No token found');
    }

    return await _competitionService.getAll(token);
  }

  @override
  Future<Resource<List<GroupModel>>> getGroupsByCompetitionId(
    int competitionId,
  ) async {
    var token = await _getToken();
    if (token == null) {
      return Error('No token found');
    }

    return await _competitionService.getGroups(token, competitionId);
  }

  @override
  Future<Resource<List<GroupStandingModel>>> getGroupsStandingByGroupsIds(
    List<int> groupIds,
  ) async {
    print('Fetching group standings for group IDs: $groupIds');
    var token = await _getToken();
    if (token == null) {
      return Error('No token found');
    }

    return await _competitionService.getGroupStandings(token, groupIds);
  }

  @override
  Future<Resource<List<TeamModel>>> getTeams() async {
    var token = await _getToken();
    if (token == null) {
      return Error('No token found');
    }

    return await _competitionService.getTeams(token);
  }

  Future<String?> _getToken() async {
    return await _secureStorage.read(SecureStorageConstants.token);
  }
}
