import 'dart:convert';

import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';

List<PredictionModel> predictionModelFromJson(String str) =>
    List<PredictionModel>.from(
      json.decode(str).map((x) => PredictionModel.fromJson(x)),
    );

String predictionModelToJson(List<PredictionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PredictionModel {
  int id;
  MatchModel match;
  int predictedHomeScore;
  int predictedAwayScore;
  int pointsEarned;

  PredictionModel({
    required this.id,
    required this.match,
    required this.predictedHomeScore,
    required this.predictedAwayScore,
    required this.pointsEarned,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) =>
      PredictionModel(
        id: json["id"],
        match: MatchModel.fromJson(json["match"]),
        predictedHomeScore: json["predicted_home_score"],
        predictedAwayScore: json["predicted_away_score"],
        pointsEarned: json["points_earned"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "match": match.toJson(),
    "predicted_home_score": predictedHomeScore,
    "predicted_away_score": predictedAwayScore,
    "points_earned": pointsEarned,
  };
}
