import 'dart:convert';

List<AgencyModel> agencyModelFromJson(String str) => List<AgencyModel>.from(json.decode(str).map((x) => AgencyModel.fromJson(x)));

String agencyModelToJson(List<AgencyModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AgencyModel {
    int id;
    String title;
    bool select;

    AgencyModel({
        required this.id,
        required this.title,
        required this.select,
    });

    factory AgencyModel.fromJson(Map<String, dynamic> json) => AgencyModel(
        id: json["id"],
        title: utf8.decode(json["title"].codeUnits),
        select: json["select"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "select": select,
    };
}
