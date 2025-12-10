import 'dart:convert';

List<CompetitionModel> competitionModelFromJson(String str) =>
    List<CompetitionModel>.from(
      json.decode(str).map((x) => CompetitionModel.fromJson(x)),
    );

String competitionModelToJson(List<CompetitionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CompetitionModel {
  int id;
  String name;
  int? year;
  String? hostCountry;
  String? logo;
  DateTime? createdAt;
  DateTime? updatedAt;

  CompetitionModel({
    required this.id,
    required this.name,
    required this.year,
    required this.hostCountry,
    required this.logo,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CompetitionModel.fromJson(Map<String, dynamic> json) =>
      CompetitionModel(
        id: json["id"],
        name: json["name"],
        year: json["year"],
        hostCountry: json["host_country"],
        logo: json["logo"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "year": year,
    "host_country": hostCountry,
    "logo": logo,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
