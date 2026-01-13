import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';

class PredictionsWithUserRooms {
  final List<PredictionModel> predictions;
  final List<RoomUserModel> roomUsers;

  PredictionsWithUserRooms({
    required this.predictions,
    required this.roomUsers,
  });
}
