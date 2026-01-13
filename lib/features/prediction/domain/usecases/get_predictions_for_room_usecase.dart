import 'package:dartz/dartz.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';

class GetPredictionsForRoomUsecase {
  PredictionRepository repository;

  GetPredictionsForRoomUsecase(this.repository);

  Future<Either<Failure, PredictionsWithUserRooms>> run(int roomId) async {
    try {
      final results = await Future.wait([
        repository.getPredictionsForRoom(roomId),
        repository.listRoomsByRoomId(roomId),
      ]);

      final predictionsResult =
          results[0] as Either<Failure, List<PredictionModel>>;
      final roomUsersResult =
          results[1] as Either<Failure, List<RoomUserModel>>;

      if (predictionsResult.isLeft()) {
        return Left(
          roomUsersResult.fold(
            (l) => l,
            (_) => throw InternalFailure('Failed to load predictions'),
          ),
        );
      }

      if (roomUsersResult.isLeft()) {
        return Left(
          roomUsersResult.fold(
            (l) => l,
            (_) => throw InternalFailure('Failed to load room users'),
          ),
        );
      }

      return Right(
        PredictionsWithUserRooms(
          predictions: predictionsResult.getOrElse(() => []),
          roomUsers: roomUsersResult.getOrElse(() => []),
        ),
      );
    } catch (e) {
      return Left(InternalFailure('Failed to get predictions for room'));
    }
  }
}
