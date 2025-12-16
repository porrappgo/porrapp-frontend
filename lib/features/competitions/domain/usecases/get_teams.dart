import 'package:porrapp_frontend/features/competitions/domain/repository/competition_repository.dart';

class GetTeamsUseCase {
  CompetitionRepository repository;

  GetTeamsUseCase(this.repository);

  run() async {
    return await repository.getTeams();
  }
}
