import 'dart:convert';

List<UsersModel> usersModelFromJson(String str) =>
    List<UsersModel>.from(json.decode(str).map((x) => UsersModel.fromJson(x)));

String usersModelToJson(List<UsersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersModel {
  int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String companyCode;
  String post;
  bool isDriver;
  bool isAdmin;
  bool isTell;
  bool isDriverRole;
  bool isScan;
  bool isPm;
  bool isCartex;
  bool isStoreManager;
  String password;
  DateTime createAt;
  DateTime updateAt;

  UsersModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.companyCode,
    required this.post,
    required this.isDriver,
    required this.isAdmin,
    required this.isTell,
    required this.isDriverRole,
    required this.isScan,
    required this.isPm,
    required this.isCartex,
    required this.isStoreManager,
    required this.password,
    required this.createAt,
    required this.updateAt,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        id: json["id"],
        firstName: utf8.decode(json["first_name"].codeUnits),
        lastName: utf8.decode(json["last_name"].codeUnits),
        phoneNumber: json["phone_number"],
        companyCode: json["company_code"],
        post: utf8.decode(json["post"].codeUnits),
        isDriver: json["is_driver"],
        isAdmin: json["is_admin"],
        isTell: json["is_tell"],
        isDriverRole: json["is_driver_role"],
        isScan: json["is_scan"],
        isPm: json["is_pm"],
        isCartex: json["is_cartex"],
        isStoreManager: json["is_store_manager"],
        password: json["password"],
        createAt: DateTime.parse(json["create_at"]),
        updateAt: DateTime.parse(json["update_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "phone_number": phoneNumber,
        "company_code": companyCode,
        "post": post,
        "is_driver": isDriver,
        "is_admin": isAdmin,
        "is_tell": isTell,
        "is_driver_role": isDriverRole,
        "is_scan": isScan,
        "is_pm": isPm,
        "is_cartex": isCartex,
        "is_store_manager": isStoreManager,
        "password": password,
        "create_at": createAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
      };
}
