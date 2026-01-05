import 'package:dartz/dartz.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';

class ListRoomsUsecase {
  PredictionRepository repository;

  ListRoomsUsecase(this.repository);

  Future<Either<Failure, List<RoomModel>>> run() async {
    return await repository.listRooms();
  }
}
