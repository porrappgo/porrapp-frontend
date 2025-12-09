import 'dart:convert';

AuthTokenModel authTokenModelFromJson(String str) =>
    AuthTokenModel.fromJson(json.decode(str));

String authTokenModelToJson(AuthTokenModel data) => json.encode(data.toJson());

class AuthTokenModel {
  String token;

  AuthTokenModel({required this.token});

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) =>
      AuthTokenModel(token: json["token"]);

  Map<String, dynamic> toJson() => {"token": token};
}
