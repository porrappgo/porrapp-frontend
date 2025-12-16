import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';

abstract class CompetitionRepository {
  // Get all competitions.
  Future<Resource<List<CompetitionModel>>> getAll();

  // Get gropus standing by list of group IDs.
  Future<Resource<List<GroupStandingModel>>> getGroupsStandingByGroupsIds(
    List<int> groupIds,
  );

  // Get groups by competition ID.
  Future<Resource<List<GroupModel>>> getGroupsByCompetitionId(
    int competitionId,
  );

  // Get teams
  Future<Resource<List<TeamModel>>> getTeams();
}
