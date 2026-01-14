import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';

import 'package:porrapp_frontend/core/util/util.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/repository/prediction_repository.dart';
import 'package:porrapp_frontend/features/prediction/domain/usecases/update_predictions_usecase.dart';

class MockPredictionRepository extends Mock implements PredictionRepository {}

void main() {
  late UpdatePredictionsUseCase usecase;
  late MockPredictionRepository repository;

  setUp(() {
    repository = MockPredictionRepository();
    usecase = UpdatePredictionsUseCase(repository);
  });

  test(
    'returns true when repository updates predictions successfully',
    () async {
      // Arrange
      final predictionUpdate = PredictionUpdateModel(predictions: []);

      when(
        () => repository.updatePredictions(predictionUpdate),
      ).thenAnswer((_) async => const Right(true));

      // Act
      final result = await usecase.run(predictionUpdate);

      // Assert
      expect(result.isRight(), true);

      result.fold(
        (_) => fail('Expected Right(true)'),
        (value) => expect(value, true),
      );

      verify(() => repository.updatePredictions(predictionUpdate)).called(1);
    },
  );

  test('returns Failure when repository fails to update predictions', () async {
    // Arrange
    final predictionUpdate = PredictionUpdateModel(predictions: []);
    final failure = ServerFailure('Error updating predictions');

    when(
      () => repository.updatePredictions(predictionUpdate),
    ).thenAnswer((_) async => Left(failure));

    // Act
    final result = await usecase.run(predictionUpdate);

    // Assert
    expect(result.isLeft(), true);

    result.fold(
      (l) => expect(l, failure),
      (_) => fail('Expected Left with Failure'),
    );

    verify(() => repository.updatePredictions(predictionUpdate)).called(1);
  });
}
