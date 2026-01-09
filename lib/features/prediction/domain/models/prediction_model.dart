import 'dart:convert';

List<PredictionModel> predictionModelFromJson(String str) =>
    List<PredictionModel>.from(
      json.decode(str).map((x) => PredictionModel.fromJson(x)),
    );

String predictionModelToJson(List<PredictionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PredictionModel {
  int id;
  Match match;
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
        match: Match.fromJson(json["match"]),
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

class Match {
  int id;
  String identifier;
  String stage;
  DateTime date;
  int homeScore;
  int awayScore;
  bool isFinished;
  bool resultProcessed;
  int competition;
  int homeTeam;
  int awayTeam;

  Match({
    required this.id,
    required this.identifier,
    required this.stage,
    required this.date,
    required this.homeScore,
    required this.awayScore,
    required this.isFinished,
    required this.resultProcessed,
    required this.competition,
    required this.homeTeam,
    required this.awayTeam,
  });

  factory Match.fromJson(Map<String, dynamic> json) => Match(
    id: json["id"],
    identifier: json["identifier"],
    stage: json["stage"],
    date: DateTime.parse(json["date"]),
    homeScore: json["home_score"],
    awayScore: json["away_score"],
    isFinished: json["is_finished"],
    resultProcessed: json["result_processed"],
    competition: json["competition"],
    homeTeam: json["home_team"],
    awayTeam: json["away_team"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "identifier": identifier,
    "stage": stage,
    "date": date.toIso8601String(),
    "home_score": homeScore,
    "away_score": awayScore,
    "is_finished": isFinished,
    "result_processed": resultProcessed,
    "competition": competition,
    "home_team": homeTeam,
    "away_team": awayTeam,
  };
}
