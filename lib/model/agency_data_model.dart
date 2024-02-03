import 'dart:convert';

List<AgencyDataModel> agencyDataModelFromJson(String str) =>
    List<AgencyDataModel>.from(
        json.decode(str).map((x) => AgencyDataModel.fromJson(x)));

String agencyDataModelToJson(List<AgencyDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AgencyDataModel {
  int id;
  String direction;
  DateTime createAt;
  DateTime updateAt;
  Agency agency;
  List<User> users;

  AgencyDataModel({
    required this.id,
    required this.direction,
    required this.createAt,
    required this.updateAt,
    required this.agency,
    required this.users,
  });

  factory AgencyDataModel.fromJson(Map<String, dynamic> json) =>
      AgencyDataModel(
        id: json["id"],
        direction: json["direction"],
        createAt: DateTime.parse(json["create_at"]),
        updateAt: DateTime.parse(json["update_at"]),
        agency: Agency.fromJson(json["agency"]),
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "direction": direction,
        "create_at": createAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
        "agency": agency.toJson(),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class Agency {
  int id;
  String title;

  Agency({
    required this.id,
    required this.title,
  });

  factory Agency.fromJson(Map<String, dynamic> json) => Agency(
        id: json["id"],
        title: utf8.decode(json["title"].codeUnits),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

class User {
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
  bool isAgency;
  String password;
  DateTime createAt;
  DateTime updateAt;

  User({
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
    required this.isAgency,
    required this.password,
    required this.createAt,
    required this.updateAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        isAgency: json["is_agency"],
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
        "is_agency": isAgency,
        "password": password,
        "create_at": createAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
      };
}
