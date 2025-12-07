import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/competition_model.dart';

abstract class CompetitionRepository {
  // Get all competitions.
  Future<Resource<List<CompetitionModel>>> getAll();
}
