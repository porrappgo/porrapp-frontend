import 'package:porrapp_frontend/features/competitions/domain/repository/competition_repository.dart';

class GetMatchesUseCase {
  CompetitionRepository repository;

  GetMatchesUseCase(this.repository);

  run() async {
    return await repository.getMatches();
  }
}
