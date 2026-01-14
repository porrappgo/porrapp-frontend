import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/room_model.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';
import 'package:porrapp_frontend/features/prediction/domain/usecases/usecases.dart';

class MockPredictionRepository extends Mock implements PredictionRepository {}

void main() {
  late MockPredictionRepository mockRepository;
  late CreateRoomUseCase useCase;

  setUp(() {
    mockRepository = MockPredictionRepository();
    useCase = CreateRoomUseCase(mockRepository);
  });

  test('run returns Right(RoomModel) when repository succeeds', () async {
    // Arrange
    final room = RoomModel(id: 1, name: 'Test Room', competition: 100);

    when(
      () => mockRepository.createRoom(room),
    ).thenAnswer((_) async => Right(room));

    // Act
    final result = await useCase.run(room);

    // Assert
    expect(result.isRight(), true);
    expect(result.getOrElse(() => throw Exception()), room);
    verify(() => mockRepository.createRoom(room)).called(1);
  });

  test('run returns Left(Failure) when repository fails', () async {
    // Arrange
    final room = RoomModel(id: 2, name: 'Error Room', competition: 200);

    when(
      () => mockRepository.createRoom(room),
    ).thenAnswer((_) async => Left(ServerFailure('Server error')));

    // Act
    final result = await useCase.run(room);

    // Assert
    expect(result.isLeft(), true);
    verify(() => mockRepository.createRoom(room)).called(1);
  });
}
