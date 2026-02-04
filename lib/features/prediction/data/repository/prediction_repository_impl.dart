import 'package:dartz/dartz.dart';
import 'package:flutter_logs/flutter_logs.dart';
import 'package:porrapp_frontend/core/util/util.dart';

import 'package:porrapp_frontend/features/prediction/data/datasource/remote/prediction_service.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';

class PredictionRepositoryImpl extends PredictionRepository {
  static const String tag = "PredictionRepositoryImpl";
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
    } on Exception catch (e) {
      FlutterLogs.logError(tag, 'createRoom', 'Exception: $e');
      return Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<RoomUserModel>>> listRooms() async {
    /**
     * Retrieve list of rooms using the prediction service.
     */
    try {
      final rooms = await _predictionService.listRooms();
      return Right(rooms);
    } on ServerException {
      return Left(ServerFailure(''));
    } on Exception catch (e) {
      FlutterLogs.logError(tag, 'listRooms', 'Exception: $e');
      return Left(ServerFailure('Unexpected error occurred'));
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
      final predictions = await _predictionService.getPredictions(roomId);
      return Right(predictions);
    } on ServerException {
      return Left(ServerFailure(''));
    } on Exception {
      return Left(ServerFailure('Unexpected error occurred'));
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
    } on Exception {
      return Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<RoomUserModel>>> listRoomsByRoomId(
    int roomId,
  ) async {
    /**
     * Retrieve list of rooms by room ID using the prediction service.
     */
    try {
      final rooms = await _predictionService.listRoomsByRoomId(roomId);
      return Right(rooms);
    } on ServerException {
      return Left(ServerFailure(''));
    } on Exception {
      return Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, RoomModel>> joinRoom(String code) async {
    try {
      final rooms = await _predictionService.joinRoom(code);
      return Right(rooms);
    } on ServerException {
      return Left(ServerFailure(''));
    } on Exception catch (e) {
      FlutterLogs.logError(tag, 'joinRoom', 'Exception: $e');
      return Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteRoom(int roomId) async {
    try {
      final deleted = await _predictionService.deleteRoom(roomId);
      return Right(deleted);
    } on ServerException {
      return Left(ServerFailure(''));
    } on Exception {
      return Left(ServerFailure('Unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, bool>> leaveRoom(int roomId) async {
    try {
      final left = await _predictionService.leaveRoom(roomId);
      return Right(left);
    } on ServerException {
      return Left(ServerFailure(''));
    } on Exception {
      return Left(ServerFailure('Unexpected error occurred'));
    }
  }
}
