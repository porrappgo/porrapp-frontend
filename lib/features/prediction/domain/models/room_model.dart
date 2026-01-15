import 'dart:convert';

RoomModel roomModelFromJson(String str) => RoomModel.fromJson(json.decode(str));

String roomModelToJson(RoomModel data) => json.encode(data.toJson());

class RoomModel {
  int? id;
  String name;
  int competition;
  String? deeplink;

  RoomModel({
    this.id,
    required this.name,
    required this.competition,
    this.deeplink,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
    id: json["id"],
    name: json["name"],
    competition: json["competition"],
    deeplink: json["deeplink"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "competition": competition,
    "deeplink": deeplink,
  };
}
