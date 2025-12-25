import 'package:dio/dio.dart';
import 'package:porrapp_frontend/core/util/resource.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';

class PredictionService {
  final Dio _dio;

  PredictionService(this._dio);

  Future<Resource<RoomModel>> createRoom(String token, RoomModel room) async {
    /**
     * Create a new prediction room using the remote API with the provided token and room data.
     */
    try {
      print('Creating room with data: ${room.toJson()}');
      final response = await _dio.post(
        '/prediction/rooms/create/',
        data: room.toJson(),
        options: Options(headers: {"Authorization": "Token $token"}),
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

  Future<Resource<List<RoomModel>>> listRooms(String token) async {
    /**
     * List all prediction rooms using the remote API with the provided token.
     */
    try {
      final response = await _dio.get(
        '/prediction/rooms/',
        options: Options(headers: {"Authorization": "Token $token"}),
      );

      if (response.statusCode == 200) {
        List<RoomModel> rooms = (response.data as List)
            .map((roomJson) => RoomModel.fromJson(roomJson))
            .toList();
        return Success<List<RoomModel>>(rooms);
      } else {
        return Error(response.data);
      }
    } catch (e) {
      // Handle error
      print('Error during listing rooms: $e');
      return Error('An error occurred during listing rooms: ${e.toString()}');
    }
  }
}
