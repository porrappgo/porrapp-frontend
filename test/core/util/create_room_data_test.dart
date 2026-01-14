import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/core/util/util.dart';

import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';

void main() {
  test(
    'creates CreateRoomData with name and competition assigned correctly',
    () {
      // Arrange
      final competition = CompetitionModel(
        id: 10,
        name: 'Test Competition',
        year: 2023,
        hostCountry: 'Test Country',
        logo: 'test_logo.png',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      // Act
      final data = CreateRoomData(
        name: 'My Prediction Room',
        competition: competition,
      );

      // Assert
      expect(data.name, 'My Prediction Room');
      expect(data.competition, competition);
    },
  );
}
