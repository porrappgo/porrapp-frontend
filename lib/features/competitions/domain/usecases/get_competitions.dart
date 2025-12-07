import 'package:porrapp_frontend/features/competitions/domain/repository/competition_repository.dart';

class GetCompetitionsUseCase {
  CompetitionRepository repository;

  GetCompetitionsUseCase(this.repository);

  run() async {
    return await repository.getAll();
  }
}
