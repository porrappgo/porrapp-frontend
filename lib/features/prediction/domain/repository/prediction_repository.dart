import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';

abstract class PredictionRepository {
  // Create a room.
  Future<Resource<RoomModel>> createRoom(RoomModel room);
}
