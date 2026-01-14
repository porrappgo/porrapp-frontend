import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/room_model.dart';

void main() {
  group('RoomModel', () {
    test('RoomModel.fromJson creates model with id', () {
      // Arrange
      final jsonMap = {
        "id": 1,
        "name": "Premier League Room",
        "competition": 100,
      };

      // Act
      final model = RoomModel.fromJson(jsonMap);

      // Assert
      expect(model.id, 1);
      expect(model.name, "Premier League Room");
      expect(model.competition, 100);
    });

    test('RoomModel.fromJson creates model with null id', () {
      // Arrange
      final jsonMap = {"id": null, "name": "La Liga Room", "competition": 200};

      // Act
      final model = RoomModel.fromJson(jsonMap);

      // Assert
      expect(model.id, isNull);
      expect(model.name, "La Liga Room");
      expect(model.competition, 200);
    });

    test('RoomModel.toJson returns valid json map', () {
      // Arrange
      final model = RoomModel(id: 10, name: "Champions Room", competition: 300);

      // Act
      final json = model.toJson();

      // Assert
      expect(json, {"id": 10, "name": "Champions Room", "competition": 300});
    });

    test('roomModelFromJson parses json string correctly', () {
      // Arrange
      final jsonString = json.encode({
        "id": 5,
        "name": "World Cup Room",
        "competition": 400,
      });

      // Act
      final model = roomModelFromJson(jsonString);

      // Assert
      expect(model.id, 5);
      expect(model.name, "World Cup Room");
      expect(model.competition, 400);
    });

    test('roomModelToJson serializes model correctly', () {
      // Arrange
      final model = RoomModel(
        id: null,
        name: "Copa America Room",
        competition: 500,
      );

      // Act
      final jsonString = roomModelToJson(model);
      final decoded = json.decode(jsonString);

      // Assert
      expect(decoded['id'], null);
      expect(decoded['name'], "Copa America Room");
      expect(decoded['competition'], 500);
    });
  });
}
