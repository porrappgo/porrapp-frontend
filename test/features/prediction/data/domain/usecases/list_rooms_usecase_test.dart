import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';
import 'package:porrapp_frontend/features/prediction/domain/usecases/list_rooms_usecase.dart';

class MockPredictionRepository extends Mock implements PredictionRepository {}

void main() {
  late ListRoomsUsecase usecase;
  late MockPredictionRepository repository;

  setUp(() {
    repository = MockPredictionRepository();
    usecase = ListRoomsUsecase(repository);
  });

  test('returns list of RoomUserModel when repository succeeds', () async {
    // Arrange
    final rooms = <RoomUserModel>[
      RoomUserModel(
        room: RoomModel(id: 1, name: 'Room 1', competition: 10),
        totalPoints: 15,
        exactHits: 3,
      ),
    ];

    when(() => repository.listRooms()).thenAnswer((_) async => Right(rooms));

    // Act
    final result = await usecase.run();

    // Assert
    expect(result.isRight(), true);

    result.fold(
      (_) => fail('Expected Right with room list'),
      (data) => expect(data, rooms),
    );

    verify(() => repository.listRooms()).called(1);
  });

  test('returns Failure when repository fails', () async {
    // Arrange
    final failure = ServerFailure('Error fetching rooms');

    when(() => repository.listRooms()).thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase.run();

    // Assert
    expect(result.isLeft(), true);

    result.fold(
      (l) => expect(l, failure),
      (_) => fail('Expected Left with Failure'),
    );

    verify(() => repository.listRooms()).called(1);
  });
}
