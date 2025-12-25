import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';

class ListRoomsUsecase {
  PredictionRepository repository;

  ListRoomsUsecase(this.repository);

  run() async {
    return await repository.listRooms();
  }
}
