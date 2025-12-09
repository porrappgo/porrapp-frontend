import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  String email;
  String password;

  AuthModel({required this.email, required this.password});

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      AuthModel(email: json["email"], password: json["password"]);

  Map<String, dynamic> toJson() => {"email": email, "password": password};
}
