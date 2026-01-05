import 'package:dio/dio.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';

class PredictionService {
  final Dio _dio;

  PredictionService(this._dio);

  Future<Resource<RoomModel>> createRoom(RoomModel room) async {
    /**
     * Create a new prediction room using the remote API with the provided token and room data.
     */
    try {
      print('Creating room with data: ${room.toJson()}');
      final response = await _dio.post(
        '/prediction/rooms/create/',
        data: room.toJson(),
      );

      if (response.statusCode == 201) {
        print('Create room response data: ${response.data}');
        return Success<RoomModel>(RoomModel.fromJson(response.data));
      } else {
        return Error(response.data);
      }
    } catch (e) {
      // Handle error
      print('Error during creating room: $e');
      return Error('An error occurred during creating room: ${e.toString()}');
    }
  }

  Future<List<RoomModel>> listRooms() async {
    /**
     * List all prediction rooms using the remote API with the provided token.
     */
    final response = await _dio.get('/prediction/rooms/');

    if (response.statusCode == 200) {
      return (response.data as List)
          .map((roomJson) => RoomModel.fromJson(roomJson))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
