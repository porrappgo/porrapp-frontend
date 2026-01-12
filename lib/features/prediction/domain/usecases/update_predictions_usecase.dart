import 'package:dartz/dartz.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';

class UpdatePredictionsUseCase {
  PredictionRepository repository;

  UpdatePredictionsUseCase(this.repository);

  Future<Either<Failure, bool>> run(
    PredictionUpdateModel predictionUpdate,
  ) async {
    return await repository.updatePredictions(predictionUpdate);
  }
}
