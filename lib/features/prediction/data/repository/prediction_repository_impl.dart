import 'package:dartz/dartz.dart';
import 'package:porrapp_frontend/core/util/util.dart';

import 'package:porrapp_frontend/features/prediction/data/datasource/remote/prediction_service.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/prediction_model.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/prediction_update_model.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/room_model.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';

class PredictionRepositoryImpl extends PredictionRepository {
  final PredictionService _predictionService;

  PredictionRepositoryImpl(this._predictionService);

  @override
  Future<Either<Failure, RoomModel>> createRoom(RoomModel room) async {
    /**
     * Create a new room using the prediction service.
     */
    try {
      final createdRoom = await _predictionService.createRoom(room);
      return Right(createdRoom);
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<RoomModel>>> listRooms() async {
    /**
     * Retrieve list of rooms using the prediction service.
     */
    try {
      final rooms = await _predictionService.listRooms();
      return Right(rooms);
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, List<PredictionModel>>> getPredictionsForRoom(
    int roomId,
  ) async {
    /**
     * Retrive predictions for a specific room using the prediction service.
     */
    try {
      final predictions = await _predictionService.getPredictions(
        roomId.toString(),
      );
      return Right(predictions);
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }

  @override
  Future<Either<Failure, bool>> updatePredictions(
    PredictionUpdateModel predictionUpdate,
  ) async {
    /**
     * Update predictions using the prediction service.
     */
    try {
      final updatedPredictions = await _predictionService.updatePredictions(
        predictionUpdate,
      );
      return Right(updatedPredictions);
    } on ServerException {
      return Left(ServerFailure(''));
    }
  }
}
