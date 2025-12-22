import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';

class CreateRoomUseCase {
  PredictionRepository repository;

  CreateRoomUseCase(this.repository);

  run(RoomModel room) async {
    return await repository.createRoom(room);
  }
}
