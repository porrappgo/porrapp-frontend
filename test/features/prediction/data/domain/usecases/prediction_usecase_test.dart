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

    // Act
    final useCases = PredictionUseCases(
      createRoomUseCase: createRoomUseCase,
      listRoomsUsecase: listRoomsUsecase,
      roomsWithCompetitionsUseCases: roomsWithCompetitionsUseCases,
      getPredictionsForRoomUsecase: getPredictionsForRoomUsecase,
      updatePredictionsUseCase: updatePredictionsUseCase,
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
  });
}
