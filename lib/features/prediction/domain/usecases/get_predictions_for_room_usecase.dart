import 'package:dartz/dartz.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';

class GetPredictionsForRoomUsecase {
  PredictionRepository repository;

  GetPredictionsForRoomUsecase(this.repository);

  Future<Either<Failure, List<PredictionModel>>> run(int roomId) async {
    return await repository.getPredictionsForRoom(roomId);
  }
}
