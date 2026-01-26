import 'package:porrapp_frontend/features/prediction/domain/usecases/usecases.dart';

class PredictionUseCases {
  CreateRoomUseCase createRoomUseCase;
  ListRoomsUsecase listRoomsUsecase;
  RoomsWithCompetitionsUseCases roomsWithCompetitionsUseCases;
  GetPredictionsForRoomUsecase getPredictionsForRoomUsecase;
  UpdatePredictionsUseCase updatePredictionsUseCase;
  JoinRoomUseCase joinRoomUseCase;

  PredictionUseCases({
    required this.createRoomUseCase,
    required this.listRoomsUsecase,
    required this.roomsWithCompetitionsUseCases,
    required this.getPredictionsForRoomUsecase,
    required this.updatePredictionsUseCase,
    required this.joinRoomUseCase,
  });
}
