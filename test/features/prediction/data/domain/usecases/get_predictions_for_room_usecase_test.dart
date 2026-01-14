import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';
import 'package:porrapp_frontend/features/prediction/domain/usecases/get_predictions_for_room_usecase.dart';

class MockPredictionRepository extends Mock implements PredictionRepository {}

void main() {
  late MockPredictionRepository repository;
  late GetPredictionsForRoomUsecase usecase;

  setUp(() {
    repository = MockPredictionRepository();
    usecase = GetPredictionsForRoomUsecase(repository);
  });

  test('returns Right when predictions and room users succeed', () async {
    // Arrange
    const roomId = 1;

    final predictions = <PredictionModel>[];
    final roomUsers = <RoomUserModel>[];

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

    result.fold((_) => fail('Expected Right'), (data) {
      expect(data.predictions, predictions);
      expect(data.roomUsers, roomUsers);
    });

    verify(() => repository.getPredictionsForRoom(roomId)).called(1);
    verify(() => repository.listRoomsByRoomId(roomId)).called(1);
  });

  test('returns Left when predictions fail', () async {
    // Arrange
    const roomId = 2;
    final failure = InternalFailure('Failed to get predictions for room');

    when(
      () => repository.getPredictionsForRoom(roomId),
    ).thenAnswer((_) async => Left(failure));

    when(
      () => repository.listRoomsByRoomId(roomId),
    ).thenAnswer((_) async => Right(<RoomUserModel>[]));

    // Act
    final result = await usecase.run(roomId);

    // Assert
    expect(result.isLeft(), true);

    result.fold((l) => expect(l, failure), (_) => fail('Expected Left'));
  });

  test('returns Left when room users fail', () async {
    // Arrange
    const roomId = 3;
    final failure = ServerFailure('Error fetching room users');

    when(
      () => repository.getPredictionsForRoom(roomId),
    ).thenAnswer((_) async => Right(<PredictionModel>[]));

    when(
      () => repository.listRoomsByRoomId(roomId),
    ).thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase.run(roomId);

    // Assert
    expect(result.isLeft(), true);

    result.fold((l) => expect(l, failure), (_) => fail('Expected Left'));
  });

  test('returns InternalFailure when an exception is thrown', () async {
    // Arrange
    const roomId = 4;

    when(
      () => repository.getPredictionsForRoom(roomId),
    ).thenThrow(Exception('Unexpected error'));

    when(
      () => repository.listRoomsByRoomId(roomId),
    ).thenAnswer((_) async => Right(<RoomUserModel>[]));

    // Act
    final result = await usecase.run(roomId);

    // Assert
    expect(result.isLeft(), true);

    result.fold(
      (l) => expect(l, isA<InternalFailure>()),
      (_) => fail('Expected Left'),
    );
  });
}
