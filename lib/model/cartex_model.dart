import 'dart:convert';

List<CartexModel> cartexModelFromJson(String str) => List<CartexModel>.from(
    json.decode(str).map((x) => CartexModel.fromJson(x)));

String cartexModelToJson(List<CartexModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CartexModel {
  int id;
  String title;
  bool is_temporary;
  bool is_always;
  bool is_back;
  bool is_manager;
  DateTime createAt;
  DateTime updateSt;
  int user;

  CartexModel({
    required this.id,
    required this.title,
    required this.is_temporary,
    required this.is_always,
    required this.is_back,
    required this.is_manager,
    required this.createAt,
    required this.updateSt,
    required this.user,
  });

  factory CartexModel.fromJson(Map<String, dynamic> json) => CartexModel(
        id: json["id"],
        title: utf8.decode(json["title"].codeUnits),
        is_temporary: json["is_temporary"],
        is_always: json["is_always"],
        is_back: json["is_back"],
        is_manager: json["is_manager"],
        createAt: DateTime.parse(json["create_at"]),
        updateSt: DateTime.parse(json["update_st"]),
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "is_temporary": is_temporary,
        "is_always": is_always,
        "is_back": is_back,
        "is_manager": is_manager,
        "create_at": createAt.toIso8601String(),
        "update_st": updateSt.toIso8601String(),
        "user": user,
      };
}
