import 'dart:convert';

AuthTokenModel authTokenModelFromJson(String str) =>
    AuthTokenModel.fromJson(json.decode(str));

String authTokenModelToJson(AuthTokenModel data) => json.encode(data.toJson());

class AuthTokenModel {
  String access;
  String? refresh;

  AuthTokenModel({required this.access, this.refresh});

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) =>
      AuthTokenModel(access: json["access"], refresh: json["refresh"]);

  Map<String, dynamic> toJson() => {"access": access, "refresh": refresh};
}
