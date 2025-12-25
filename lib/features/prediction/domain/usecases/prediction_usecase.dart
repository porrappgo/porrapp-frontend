import 'package:porrapp_frontend/features/prediction/domain/usecases/usecases.dart';

class PredictionUseCases {
  CreateRoomUseCase createRoomUseCase;
  ListRoomsUsecase listRoomsUsecase;

  PredictionUseCases({
    required this.createRoomUseCase,
    required this.listRoomsUsecase,
  });
}
