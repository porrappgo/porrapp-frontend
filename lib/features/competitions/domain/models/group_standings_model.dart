import 'dart:convert';

List<GroupStandingModel> groupStandingModelFromJson(String str) =>
    List<GroupStandingModel>.from(
      json.decode(str).map((x) => GroupStandingModel.fromJson(x)),
    );

String groupStandingModelToJson(List<GroupStandingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupStandingModel {
  int id;
  int position;
  int points;
  DateTime createdAt;
  DateTime updatedAt;
  int team;
  int group;

  GroupStandingModel({
    required this.id,
    required this.position,
    required this.points,
    required this.createdAt,
    required this.updatedAt,
    required this.team,
    required this.group,
  });

  factory GroupStandingModel.fromJson(Map<String, dynamic> json) =>
      GroupStandingModel(
        id: json["id"],
        position: json["position"],
        points: json["points"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        team: json["team"],
        group: json["group"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "position": position,
    "points": points,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "team": team,
    "group": group,
  };
}
