import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/competitions/domain/repository/competition_repository.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';
import 'package:porrapp_frontend/features/prediction/domain/usecases/rooms_with_competitions_usecases.dart';

class MockPredictionRepository extends Mock implements PredictionRepository {}

class MockCompetitionRepository extends Mock implements CompetitionRepository {}

void main() {
  late RoomsWithCompetitionsUseCases usecase;
  late MockPredictionRepository predictionRepository;
  late MockCompetitionRepository competitionRepository;

  setUp(() {
    predictionRepository = MockPredictionRepository();
    competitionRepository = MockCompetitionRepository();
    usecase = RoomsWithCompetitionsUseCases(
      predictionRepository,
      competitionRepository,
    );
  });

  test('returns Failure when listRooms fails', () async {
    // Arrange
    final failure = ServerFailure('Error fetching rooms');

    when(
      () => predictionRepository.listRooms(),
    ).thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase.run();

    // Assert
    expect(result.isLeft(), true);

    result.fold(
      (l) => expect(l, failure),
      (_) => fail('Expected Left with Failure'),
    );

    verify(() => predictionRepository.listRooms()).called(1);
    verifyNever(() => competitionRepository.getAll());
  });

  test('returns Failure when getAll competitions fails', () async {
    // Arrange
    final rooms = <RoomUserModel>[
      RoomUserModel(
        room: RoomModel(id: 1, name: 'Room 1', competition: 10),
        totalPoints: 20,
        exactHits: 4,
      ),
    ];

    final failure = ServerFailure('Error fetching competitions');

    when(
      () => predictionRepository.listRooms(),
    ).thenAnswer((_) async => Right(rooms));

    when(
      () => competitionRepository.getAll(),
    ).thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase.run();

    // Assert
    expect(result.isLeft(), true);

    result.fold(
      (l) => expect(l, failure),
      (_) => fail('Expected Left with Failure'),
    );

    verify(() => predictionRepository.listRooms()).called(1);
    verify(() => competitionRepository.getAll()).called(1);
  });

  test('returns RoomsWithCompetitions when both calls succeed', () async {
    // Arrange
    final rooms = <RoomUserModel>[
      RoomUserModel(
        room: RoomModel(id: 1, name: 'Room 1', competition: 10),
        totalPoints: 25,
        exactHits: 6,
      ),
    ];

    final competitions = <CompetitionModel>[
      CompetitionModel(
        id: 10,
        name: 'Test Competition',
        year: 2023,
        hostCountry: 'Test Country',
        logo: 'test_logo.png',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    when(
      () => predictionRepository.listRooms(),
    ).thenAnswer((_) async => Right(rooms));

    when(
      () => competitionRepository.getAll(),
    ).thenAnswer((_) async => Right(competitions));

    // Act
    final result = await usecase.run();

    // Assert
    expect(result.isRight(), true);

    result.fold((_) => fail('Expected Right with RoomsWithCompetitions'), (
      data,
    ) {
      expect(data.rooms, rooms);
      expect(data.competitions, competitions);
    });

    verify(() => predictionRepository.listRooms()).called(1);
    verify(() => competitionRepository.getAll()).called(1);
  });
}
