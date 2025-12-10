import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  String email;
  String name;

  AuthModel({required this.email, required this.name});

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      AuthModel(email: json["email"], name: json["name"]);

  Map<String, dynamic> toJson() => {"email": email, "name": name};
}
