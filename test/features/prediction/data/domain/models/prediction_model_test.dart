import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';

void main() {
  group('PredictionModel', () {
    late MatchModel match;

    setUp(() {
      match = MatchModel(
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
      );
    });

    test('fromJson creates a valid PredictionModel', () {
      // Arrange
      final jsonMap = {
        "id": 10,
        "match": {
          "id": 10,
          "home_team": {
            "id": 0,
            "identifier": "string",
            "name": "string",
            "flag": "string",
            "competition": 0,
          },
          "away_team": {
            "id": 0,
            "identifier": "string",
            "name": "string",
            "flag": "string",
            "competition": 0,
          },
          "identifier": "string",
          "stage": "string",
          "date": "2026-01-13T07:45:42.704Z",
          "home_score": 0,
          "away_score": 0,
          "is_finished": true,
          "result_processed": true,
          "created_at": "2026-01-13T07:45:42.704Z",
          "updated_at": "2026-01-13T07:45:42.704Z",
          "competition": 1,
        },
        "predicted_home_score": 2,
        "predicted_away_score": 1,
        "points_earned": 3,
        "is_predicted": false,
      };

      // Act
      final model = PredictionModel.fromJson(jsonMap);

      // Assert
      expect(model.id, 10);
      expect(model.match.id, match.id);
      expect(model.predictedHomeScore, 2);
      expect(model.predictedAwayScore, 1);
      expect(model.pointsEarned, 3);
      expect(model.isPredicted, false);
    });

    test('toJson returns a valid json map', () {
      // Arrange
      final model = PredictionModel(
        id: 1,
        match: match,
        predictedHomeScore: 2,
        predictedAwayScore: 1,
        pointsEarned: 3,
        isPredicted: false,
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json['id'], 1);
      expect(json['match'], match.toJson());
      expect(json['predicted_home_score'], 2);
      expect(json['predicted_away_score'], 1);
      expect(json['points_earned'], 3);
      expect(json['is_predicted'], false);
    });

    test('predictionModelFromJson parses list correctly', () {
      // Arrange
      final jsonString = json.encode([
        {
          "id": 1,
          "match": match.toJson(),
          "predicted_home_score": 1,
          "predicted_away_score": 0,
          "points_earned": 3,
          "is_predicted": true,
        },
        {
          "id": 2,
          "match": match.toJson(),
          "predicted_home_score": 2,
          "predicted_away_score": 2,
          "points_earned": 1,
          "is_predicted": false,
        },
      ]);

      // Act
      final result = predictionModelFromJson(jsonString);

      // Assert
      expect(result.length, 2);
      expect(result.first, isA<PredictionModel>());
      expect(result.last.id, 2);
      expect(result.last.pointsEarned, 1);
      expect(result.last.isPredicted, false);
    });

    test('predictionModelToJson serializes list correctly', () {
      // Arrange
      final models = [
        PredictionModel(
          id: 1,
          match: match,
          predictedHomeScore: 1,
          predictedAwayScore: 0,
          pointsEarned: 3,
          isPredicted: true,
        ),
        PredictionModel(
          id: 2,
          match: match,
          predictedHomeScore: 2,
          predictedAwayScore: 2,
          pointsEarned: 1,
          isPredicted: false,
        ),
      ];

      // Act
      final jsonString = predictionModelToJson(models);
      final decoded = json.decode(jsonString) as List;

      // Assert
      expect(decoded.length, 2);
      expect(decoded.first['id'], 1);
      expect(decoded.last['points_earned'], 1);
      expect(decoded.last['is_predicted'], false);
    });

    test('copyWith overrides predicted scores', () {
      // Arrange
      final model = PredictionModel(
        id: 1,
        match: match,
        predictedHomeScore: 1,
        predictedAwayScore: 1,
        pointsEarned: 0,
        isPredicted: false,
      );

      // Act
      final updated = model.copyWith(
        predictedHomeScore: 3,
        predictedAwayScore: 2,
        isPredicted: true,
      );

      // Assert
      expect(updated.predictedHomeScore, 3);
      expect(updated.predictedAwayScore, 2);
      expect(updated.id, model.id);
      expect(updated.pointsEarned, model.pointsEarned);
      expect(updated.match, model.match);
      expect(updated.isPredicted, true);
    });

    test('copyWith keeps original values when parameters are null', () {
      // Arrange
      final model = PredictionModel(
        id: 1,
        match: match,
        predictedHomeScore: 1,
        predictedAwayScore: 1,
        pointsEarned: 0,
        isPredicted: false,
      );

      // Act
      final copied = model.copyWith();

      // Assert
      expect(copied.predictedHomeScore, model.predictedHomeScore);
      expect(copied.predictedAwayScore, model.predictedAwayScore);
      expect(copied.match, model.match);
      expect(copied.pointsEarned, model.pointsEarned);
      expect(copied.id, model.id);
    });
  });
}
