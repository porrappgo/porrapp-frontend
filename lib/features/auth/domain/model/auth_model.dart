import 'dart:convert';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  String account;
  String phone;

  AuthResponse({required this.account, required this.phone});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      AuthResponse(account: json["account"], phone: json["phone"]);

  Map<String, dynamic> toJson() => {"account": account, "phone": phone};
}
