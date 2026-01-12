import 'dart:convert';

import 'package:porrapp_frontend/features/competitions/domain/models/models.dart';

List<MatchModel> matchModelFromJson(String str) =>
    List<MatchModel>.from(json.decode(str).map((x) => MatchModel.fromJson(x)));

String matchModelToJson(List<MatchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MatchModel {
  int id;
  String stage;
  DateTime date;
  int homeScore;
  int awayScore;
  bool isFinished;
  DateTime createdAt;
  DateTime updatedAt;
  int competition;
  TeamModel homeTeam;
  TeamModel awayTeam;

  MatchModel({
    required this.id,
    required this.stage,
    required this.date,
    required this.homeScore,
    required this.awayScore,
    required this.isFinished,
    required this.createdAt,
    required this.updatedAt,
    required this.competition,
    required this.homeTeam,
    required this.awayTeam,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
    id: json["id"],
    stage: json["stage"],
    date: DateTime.parse(json["date"]),
    homeScore: json["home_score"],
    awayScore: json["away_score"],
    isFinished: json["is_finished"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    competition: json["competition"],
    homeTeam: TeamModel.fromJson(json["home_team"]),
    awayTeam: TeamModel.fromJson(json["away_team"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stage": stage,
    "date": date.toIso8601String(),
    "home_score": homeScore,
    "away_score": awayScore,
    "is_finished": isFinished,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "competition": competition,
    "home_team": homeTeam,
    "away_team": awayTeam,
  };
}
