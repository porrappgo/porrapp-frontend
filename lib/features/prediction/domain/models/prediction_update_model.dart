import 'dart:convert';

PredictionUpdateModel predictionUpdateModelFromJson(String str) =>
    PredictionUpdateModel.fromJson(json.decode(str));

String predictionUpdateModelToJson(PredictionUpdateModel data) =>
    json.encode(data.toJson());

class PredictionUpdateModel {
  List<Prediction> predictions;

  PredictionUpdateModel({required this.predictions});

  factory PredictionUpdateModel.fromJson(Map<String, dynamic> json) =>
      PredictionUpdateModel(
        predictions: List<Prediction>.from(
          json["predictions"].map((x) => Prediction.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "predictions": List<Map<String, dynamic>>.from(
      predictions.map((x) => x.toJson()),
    ),
  };
}

class Prediction {
  int id;
  int predictedHomeScore;
  int predictedAwayScore;

  Prediction({
    required this.id,
    required this.predictedHomeScore,
    required this.predictedAwayScore,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
    id: json["id"],
    predictedHomeScore: json["predicted_home_score"],
    predictedAwayScore: json["predicted_away_score"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "predicted_home_score": predictedHomeScore,
    "predicted_away_score": predictedAwayScore,
  };
}
