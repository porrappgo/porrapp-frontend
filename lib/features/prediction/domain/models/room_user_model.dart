import 'dart:convert';

import 'package:porrapp_frontend/features/auth/domain/model/model.dart';
import 'package:porrapp_frontend/features/prediction/domain/models/models.dart';

List<RoomUserModel> roomUserModelFromJson(String str) =>
    List<RoomUserModel>.from(
      json.decode(str).map((x) => RoomUserModel.fromJson(x)),
    );

String roomUserModelToJson(List<RoomUserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RoomUserModel {
  RoomModel room;
  int totalPoints;
  int exactHits;
  AuthModel? user;

  RoomUserModel({
    required this.room,
    required this.totalPoints,
    required this.exactHits,
    this.user,
  });

  factory RoomUserModel.fromJson(Map<String, dynamic> json) => RoomUserModel(
    room: RoomModel.fromJson(json["room"]),
    totalPoints: json["total_points"],
    exactHits: json["exact_hits"],
    user: json["user"] == null ? null : AuthModel.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "room": room.toJson(),
    "total_points": totalPoints,
    "exact_hits": exactHits,
    "user": user?.toJson(),
  };
}
