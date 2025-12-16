import 'package:porrapp_frontend/features/competitions/domain/repository/competition_repository.dart';

class GetGroupsStandingsUseCase {
  CompetitionRepository repository;

  GetGroupsStandingsUseCase(this.repository);

  run(List<int> groupIds) async {
    return await repository.getGroupsStandingByGroupsIds(groupIds);
  }
}
