import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/room_user_model.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/room_model.dart';
import 'package:porrapp_frontend/features/auth/domain/model/model.dart';

void main() {
  group('RoomUserModel', () {
    Map<String, dynamic> roomJson() => {
      "id": 1,
      "name": "Test Room",
      "competition": 100,
    };

    Map<String, dynamic> userJson() => {
      "name": "john",
      "email": "john@test.com",
    };

    test('RoomUserModel.fromJson creates model with user', () {
      // Arrange
      final jsonMap = {
        "room": roomJson(),
        "total_points": 15,
        "exact_hits": 3,
        "user": userJson(),
      };

      // Act
      final model = RoomUserModel.fromJson(jsonMap);

      // Assert
      expect(model.room, isA<RoomModel>());
      expect(model.room.id, 1);
      expect(model.totalPoints, 15);
      expect(model.exactHits, 3);
      expect(model.user, isA<AuthModel>());
      expect(model.user?.email, "john@test.com");
    });

    test('RoomUserModel.fromJson creates model with null user', () {
      // Arrange
      final jsonMap = {
        "room": roomJson(),
        "total_points": 8,
        "exact_hits": 1,
        "user": null,
      };

      // Act
      final model = RoomUserModel.fromJson(jsonMap);

      // Assert
      expect(model.user, isNull);
      expect(model.totalPoints, 8);
      expect(model.exactHits, 1);
    });

    test('RoomUserModel.toJson returns valid json map with user', () {
      // Arrange
      final model = RoomUserModel(
        room: RoomModel(id: 2, name: "Another Room", competition: 200),
        totalPoints: 20,
        exactHits: 5,
        user: AuthModel(email: "alice@test.com", name: "alice"),
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json['room']['id'], 2);
      expect(json['total_points'], 20);
      expect(json['exact_hits'], 5);
      expect(json['user']['email'], "alice@test.com");
    });

    test('RoomUserModel.toJson returns valid json map with null user', () {
      // Arrange
      final model = RoomUserModel(
        room: RoomModel(id: 3, name: "No User Room", competition: 300),
        totalPoints: 0,
        exactHits: 0,
        user: null,
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json['user'], isNull);
      expect(json['room']['name'], "No User Room");
    });

    test('roomUserModelFromJson parses list correctly', () {
      // Arrange
      final jsonString = json.encode([
        {
          "room": roomJson(),
          "total_points": 5,
          "exact_hits": 1,
          "user": userJson(),
        },
        {"room": roomJson(), "total_points": 10, "exact_hits": 2, "user": null},
      ]);

      // Act
      final result = roomUserModelFromJson(jsonString);

      // Assert
      expect(result.length, 2);
      expect(result.first, isA<RoomUserModel>());
      expect(result.last.user, isNull);
    });

    test('roomUserModelToJson serializes list correctly', () {
      // Arrange
      final models = [
        RoomUserModel(
          room: RoomModel(id: 1, name: "Room 1", competition: 1),
          totalPoints: 5,
          exactHits: 1,
          user: null,
        ),
      ];

      // Act
      final jsonString = roomUserModelToJson(models);
      final decoded = json.decode(jsonString);

      // Assert
      expect(decoded.length, 1);
      expect(decoded[0]['total_points'], 5);
      expect(decoded[0]['user'], null);
    });
  });
}
