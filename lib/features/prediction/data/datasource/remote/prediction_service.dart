import 'package:dio/dio.dart';
import 'package:flutter_logs/flutter_logs.dart';

import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';

class PredictionService {
  static const String tag = 'PredictionService';

  final Dio _dio;

  PredictionService(this._dio);

  Future<RoomModel> createRoom(RoomModel room) async {
    /**
     * Create a new prediction room using the remote API with the provided token and room data.
     */
    FlutterLogs.logInfo(
      tag,
      'createRoom',
      'Creating room with data: ${room.toJson()}',
    );
    final response = await _dio.post(
      '/prediction/rooms/create/',
      data: room.toJson(),
    );

    if (response.statusCode == 201) {
      return RoomModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  Future<RoomModel> joinRoom(String invitationCode) async {
    /**
     * Join a prediction room using the remote API with the provided token and invitation code.
     */
    FlutterLogs.logInfo(
      tag,
      'joinRoom',
      'Joining room with invitation code: $invitationCode',
    );
    final response = await _dio.post(
      '/prediction/rooms/join/',
      data: {'invitation_code': invitationCode},
    );

    FlutterLogs.logInfo(
      tag,
      'joinRoom',
      'Response status code: ${response.statusCode}, data: ${response.data}',
    );

    if (response.statusCode == 201) {
      return RoomModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  Future<List<RoomUserModel>> listRooms() async {
    /**
     * List all prediction rooms using the remote API with the provided token.
     */
    final response = await _dio.get('/prediction/room-users/');

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((roomJson) => RoomUserModel.fromJson(roomJson))
          .toList();
    } else {
      throw ServerException();
    }
  }

  Future<List<RoomUserModel>> listRoomsByRoomId(int roomId) async {
    /**
     * List all prediction rooms using the remote API with the provided token.
     */
    final response = await _dio.get('/prediction/room-users/$roomId/');

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((roomJson) => RoomUserModel.fromJson(roomJson))
          .toList();
    } else {
      throw ServerException();
    }
  }

  Future<List<PredictionModel>> getPredictions(int roomId) async {
    /**
     * Get predictions for a specific room using the remote API with the provided token and room ID.
     */
    final response = await _dio.get('/prediction/predictions/$roomId/');

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((predictionJson) => PredictionModel.fromJson(predictionJson))
          .toList();
    } else {
      throw ServerException();
    }
  }

  Future<bool> updatePredictions(PredictionUpdateModel predictionUpdate) async {
    /**
     * Update predictions using the remote API with the provided token and prediction update data.
     */
    FlutterLogs.logInfo(
      tag,
      'updatePredictions',
      'Updating predictions with data: ${predictionUpdate.toJson()}',
    );
    final response = await _dio.patch(
      '/prediction/predictions/update/',
      data: predictionUpdate.toJson(),
    );

    if (response.statusCode == 200) {
      // Answer {"status": "predictions updated"}
      return response.data.containsKey('success') &&
          response.data['success'] == true;
    } else {
      throw ServerException();
    }
  }
}
