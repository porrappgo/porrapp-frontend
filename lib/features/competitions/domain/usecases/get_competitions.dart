import 'package:dartz/dartz.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/competitions/domain/repository/competition_repository.dart';

class GetCompetitionsUseCase {
  CompetitionRepository repository;

  GetCompetitionsUseCase(this.repository);

  Future<Either<Failure, List<CompetitionModel>>> run() async {
    return await repository.getAll();
  }
}
