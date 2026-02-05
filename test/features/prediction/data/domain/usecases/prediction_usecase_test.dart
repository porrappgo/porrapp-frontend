import 'package:flutter_test/flutter_test.dart';

import 'package:porrapp_frontend/features/prediction/domain/usecases/usecases.dart';

import '../../../../../fakes/fake_respository.dart';

void main() {
  test('creates PredictionUseCases with all use cases assigned correctly', () {
    // Arrange
    final createRoomUseCase = CreateRoomUseCase(FakePredictionRepository());
    final listRoomsUsecase = ListRoomsUsecase(FakePredictionRepository());
    final roomsWithCompetitionsUseCases = RoomsWithCompetitionsUseCases(
      FakePredictionRepository(),
      FakeCompetitionRepository(),
    );
    final getPredictionsForRoomUsecase = GetPredictionsForRoomUsecase(
      FakePredictionRepository(),
    );
    final updatePredictionsUseCase = UpdatePredictionsUseCase(
      FakePredictionRepository(),
    );
    final joinRoomUseCase = JoinRoomUseCase(FakePredictionRepository());
    final leaveRoomUseCase = LeaveRoomUseCase(FakePredictionRepository());
    final deleteRoomUseCase = DeleteRoomUseCase(FakePredictionRepository());

    // Act
    final useCases = PredictionUseCases(
      createRoomUseCase: createRoomUseCase,
      listRoomsUsecase: listRoomsUsecase,
      roomsWithCompetitionsUseCases: roomsWithCompetitionsUseCases,
      getPredictionsForRoomUsecase: getPredictionsForRoomUsecase,
      updatePredictionsUseCase: updatePredictionsUseCase,
      joinRoomUseCase: joinRoomUseCase,
      leaveRoomUseCase: leaveRoomUseCase,
      deleteRoomUseCase: deleteRoomUseCase,
    );

    // Assert
    expect(useCases.createRoomUseCase, createRoomUseCase);
    expect(useCases.listRoomsUsecase, listRoomsUsecase);
    expect(
      useCases.roomsWithCompetitionsUseCases,
      roomsWithCompetitionsUseCases,
    );
    expect(useCases.getPredictionsForRoomUsecase, getPredictionsForRoomUsecase);
    expect(useCases.updatePredictionsUseCase, updatePredictionsUseCase);
    expect(useCases.joinRoomUseCase, joinRoomUseCase);
    expect(useCases.leaveRoomUseCase, leaveRoomUseCase);
    expect(useCases.deleteRoomUseCase, deleteRoomUseCase);
  });
}
