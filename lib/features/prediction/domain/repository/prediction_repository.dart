import 'package:dartz/dartz.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';

abstract class PredictionRepository {
  // Create a room.
  Future<Either<Failure, RoomModel>> createRoom(RoomModel room);

  // List all rooms.
  Future<Either<Failure, List<RoomModel>>> listRooms();

  // Get predictions for a specific room.
  Future<Either<Failure, List<PredictionModel>>> getPredictionsForRoom(
    int roomId,
  );
}
