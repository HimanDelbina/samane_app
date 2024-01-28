import 'dart:convert';

List<TellModel> tellModelFromJson(String str) => List<TellModel>.from(json.decode(str).map((x) => TellModel.fromJson(x)));

String tellModelToJson(List<TellModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TellModel {
    int id;
    String phone;
    String title;

    TellModel({
        required this.id,
        required this.phone,
        required this.title,
    });

    factory TellModel.fromJson(Map<String, dynamic> json) => TellModel(
        id: json["id"],
        phone: json["phone"],
        title: utf8.decode(json["title"].codeUnits),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "phone": phone,
        "title": title,
    };
}
