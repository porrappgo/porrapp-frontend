import 'package:dartz/dartz.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';

class GetPredictionsForRoomUsecase {
  PredictionRepository repository;

  GetPredictionsForRoomUsecase(this.repository);

  Future<Either<Failure, PredictionsWithUserRooms>> run(int roomId) async {
    final predictionsResult = await repository.getPredictionsForRoom(roomId);

    return predictionsResult.fold((failure) => Left(failure), (
      predictions,
    ) async {
      final roomUsersResult = await repository.listRoomsByRoomId(roomId);
      return roomUsersResult.fold(
        (failure) => Left(failure),
        (roomUsers) => Right(
          PredictionsWithUserRooms(
            predictions: predictions,
            roomUsers: roomUsers,
          ),
        ),
      );
    });
  }
}
