import 'package:porrapp_frontend/features/competitions/domain/repository/competition_repository.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';

class FakePredictionRepository implements PredictionRepository {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeCompetitionRepository implements CompetitionRepository {
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
