import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/prediction_update_model.dart';

void main() {
  group('PredictionUpdateModel', () {
    test('Prediction.fromJson creates a valid Prediction', () {
      // Arrange
      final jsonMap = {
        "id": 1,
        "predicted_home_score": 2,
        "predicted_away_score": 1,
      };

      // Act
      final prediction = Prediction.fromJson(jsonMap);

      // Assert
      expect(prediction.id, 1);
      expect(prediction.predictedHomeScore, 2);
      expect(prediction.predictedAwayScore, 1);
    });

    test('Prediction.toJson returns a valid json map', () {
      // Arrange
      final prediction = Prediction(
        id: 1,
        predictedHomeScore: 3,
        predictedAwayScore: 2,
      );

      // Act
      final json = prediction.toJson();

      // Assert
      expect(json, {
        "id": 1,
        "predicted_home_score": 3,
        "predicted_away_score": 2,
      });
    });

    test('PredictionUpdateModel.fromJson creates a valid model', () {
      // Arrange
      final jsonMap = {
        "predictions": [
          {"id": 1, "predicted_home_score": 1, "predicted_away_score": 0},
          {"id": 2, "predicted_home_score": 2, "predicted_away_score": 2},
        ],
      };

      // Act
      final model = PredictionUpdateModel.fromJson(jsonMap);

      // Assert
      expect(model.predictions.length, 2);
      expect(model.predictions.first, isA<Prediction>());
      expect(model.predictions.last.id, 2);
    });

    test('PredictionUpdateModel.toJson returns a valid json map', () {
      // Arrange
      final model = PredictionUpdateModel(
        predictions: [
          Prediction(id: 1, predictedHomeScore: 2, predictedAwayScore: 1),
          Prediction(id: 2, predictedHomeScore: 0, predictedAwayScore: 0),
        ],
      );

      // Act
      final json = model.toJson();

      // Assert
      expect(json['predictions'], isA<List>());
      expect(json['predictions'].length, 2);
      expect(json['predictions'][0]['id'], 1);
      expect(json['predictions'][1]['predicted_away_score'], 0);
    });

    test('predictionUpdateModelFromJson parses json string correctly', () {
      // Arrange
      final jsonString = json.encode({
        "predictions": [
          {"id": 1, "predicted_home_score": 2, "predicted_away_score": 1},
        ],
      });

      // Act
      final model = predictionUpdateModelFromJson(jsonString);

      // Assert
      expect(model.predictions.length, 1);
      expect(model.predictions.first.id, 1);
    });

    test('predictionUpdateModelToJson serializes model correctly', () {
      // Arrange
      final model = PredictionUpdateModel(
        predictions: [
          Prediction(id: 99, predictedHomeScore: 4, predictedAwayScore: 3),
        ],
      );

      // Act
      final jsonString = predictionUpdateModelToJson(model);
      final decoded = json.decode(jsonString);

      // Assert
      expect(decoded['predictions'][0]['id'], 99);
      expect(decoded['predictions'][0]['predicted_home_score'], 4);
      expect(decoded['predictions'][0]['predicted_away_score'], 3);
    });
  });
}
