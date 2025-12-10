import 'dart:convert';

List<TeamModel> teamModelFromJson(String str) =>
    List<TeamModel>.from(json.decode(str).map((x) => TeamModel.fromJson(x)));

String teamModelToJson(List<TeamModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeamModel {
  int id;
  String name;
  String? flag;
  int competition;

  TeamModel({
    required this.id,
    required this.name,
    required this.flag,
    required this.competition,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
    id: json["id"],
    name: json["name"],
    flag: json["flag"],
    competition: json["competition"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "flag": flag,
    "competition": competition,
  };
}
