import 'dart:convert';

List<UniversityDetailsModel> universityDetailsModelFromJson(String str) =>
    List<UniversityDetailsModel>.from(
        json.decode(str).map((x) => UniversityDetailsModel.fromJson(x)));

String universityDetailsModelToJson(List<UniversityDetailsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UniversityDetailsModel {
  UniversityDetailsModel({
    required this.country,
    required this.domains,
    required this.webPages,
    required this.alphaTwoCode,
    required this.name,
    required this.stateProvince,
  });

  String country;
  List<String> domains;
  List<String> webPages;
  String alphaTwoCode;
  String name;
  String stateProvince;

  factory UniversityDetailsModel.fromJson(Map<String, dynamic> json) =>
      UniversityDetailsModel(
        country: json["country"],
        domains: List<String>.from(json["domains"].map((x) => x)),
        webPages: List<String>.from(json["web_pages"].map((x) => x)),
        alphaTwoCode: json["alpha_two_code"],
        name: json["name"],
        stateProvince: json["state-province"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "domains": List<dynamic>.from(domains.map((x) => x)),
        "web_pages": List<dynamic>.from(webPages.map((x) => x)),
        "alpha_two_code": alphaTwoCode,
        "name": name,
        "state-province": stateProvince,
      };
}
