import 'package:dartz/dartz.dart';
import 'package:porrapp_frontend/core/util/util.dart';

import 'package:porrapp_frontend/features/prediction/data/datasource/remote/prediction_service.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/room_model.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';

class PredictionRepositoryImpl extends PredictionRepository {
  final PredictionService _predictionService;

  PredictionRepositoryImpl(this._predictionService);

  @override
  Future<Resource<RoomModel>> createRoom(RoomModel room) async {
    /**
     * Retrieve the token from secure storage
     * and create a new prediction room using the prediction service.
     */
    return await _predictionService.createRoom(room);
  }

  @override
  Future<Either<Failure, List<RoomModel>>> listRooms() async {
    /**
     * Retrieve the token from secure storage
     * and list all prediction rooms using the prediction service.
     */
    try {
      final rooms = await _predictionService.listRooms();
      return Right(rooms);
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }
}
