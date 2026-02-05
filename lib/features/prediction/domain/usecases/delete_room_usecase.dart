import 'package:dartz/dartz.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';

class DeleteRoomUseCase {
  PredictionRepository repository;

  DeleteRoomUseCase(this.repository);

  Future<Either<Failure, bool>> run(int roomId) async {
    return await repository.deleteRoom(roomId);
  }
}
