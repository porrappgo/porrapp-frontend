import 'package:porrapp_frontend/features/competitions/domain/repository/competition_repository.dart';

class GetGroupsUseCase {
  CompetitionRepository repository;

  GetGroupsUseCase(this.repository);

  run(int competitionId) async {
    return await repository.getGroupsByCompetitionId(competitionId);
  }
}
