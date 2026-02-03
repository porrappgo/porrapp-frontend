import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';
import 'package:porrapp_frontend/features/prediction/domain/usecases/get_predictions_for_room_usecase.dart';

class MockPredictionRepository extends Mock implements PredictionRepository {}

void main() {
  late GetPredictionsForRoomUsecase usecase;
  late MockPredictionRepository repository;

  setUp(() {
    repository = MockPredictionRepository();
    usecase = GetPredictionsForRoomUsecase(repository);
  });

  const roomId = 1;

  test('returns Failure when getPredictionsForRoom fails', () async {
    // Arrange
    final failure = ServerFailure('Error fetching predictions');

    when(
      () => repository.getPredictionsForRoom(roomId),
    ).thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase.run(roomId);

    // Assert
    expect(result.isLeft(), true);

    result.fold(
      (l) => expect(l, failure),
      (_) => fail('Expected Left with Failure'),
    );

    verify(() => repository.getPredictionsForRoom(roomId)).called(1);
    verifyNever(() => repository.listRoomsByRoomId(any()));
  });

  test('returns Failure when listRoomsByRoomId fails', () async {
    // Arrange
    final predictions = <PredictionModel>[];
    final failure = ServerFailure('Error fetching room users');

    when(
      () => repository.getPredictionsForRoom(roomId),
    ).thenAnswer((_) async => Right(predictions));

    when(
      () => repository.listRoomsByRoomId(roomId),
    ).thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase.run(roomId);

    // Assert
    expect(result.isLeft(), true);

    result.fold(
      (l) => expect(l, failure),
      (_) => fail('Expected Left with Failure'),
    );

    verify(() => repository.getPredictionsForRoom(roomId)).called(1);
    verify(() => repository.listRoomsByRoomId(roomId)).called(1);
  });

  test('returns PredictionsWithUserRooms when both calls succeed', () async {
    // Arrange
    final predictions = <PredictionModel>[
      PredictionModel(
        id: 1,
        match: MatchModel(
          id: 10,
          homeTeam: TeamModel(
            id: 1,
            name: 'Team A',
            flag: 'http://example.com/cresta.png',
            competition: 1,
          ),
          awayTeam: TeamModel(
            id: 2,
            name: 'Team B',
            flag: 'http://example.com/cresta2.png',
            competition: 1,
          ),
          stage: "string",
          date: DateTime.now(),
          homeScore: 0,
          awayScore: 0,
          isFinished: false,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          competition: 1,
        ),
        predictedHomeScore: 2,
        predictedAwayScore: 1,
        pointsEarned: 3,
        isPredicted: true,
      ),
    ];

    final roomUsers = <RoomUserModel>[
      RoomUserModel(
        room: RoomModel(id: 1, name: 'Room 1', competition: 10),
        totalPoints: 12,
        exactHits: 2,
      ),
    ];

    when(
      () => repository.getPredictionsForRoom(roomId),
    ).thenAnswer((_) async => Right(predictions));

    when(
      () => repository.listRoomsByRoomId(roomId),
    ).thenAnswer((_) async => Right(roomUsers));

    // Act
    final result = await usecase.run(roomId);

    // Assert
    expect(result.isRight(), true);

    result.fold((_) => fail('Expected Right with PredictionsWithUserRooms'), (
      data,
    ) {
      expect(data.predictions, predictions);
      expect(data.roomUsers, roomUsers);
    });

    verify(() => repository.getPredictionsForRoom(roomId)).called(1);
    verify(() => repository.listRoomsByRoomId(roomId)).called(1);
  });
}
