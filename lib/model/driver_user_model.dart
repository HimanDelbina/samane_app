// To parse this JSON data, do
//
//     final driverUserModel = driverUserModelFromJson(jsonString);

import 'dart:convert';

List<DriverUserModel> driverUserModelFromJson(String str) => List<DriverUserModel>.from(json.decode(str).map((x) => DriverUserModel.fromJson(x)));

String driverUserModelToJson(List<DriverUserModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DriverUserModel {
    int id;
    DateTime createAt;
    DateTime updateAt;
    Driver driver;
    List<Driver> users;

    DriverUserModel({
        required this.id,
        required this.createAt,
        required this.updateAt,
        required this.driver,
        required this.users,
    });

    factory DriverUserModel.fromJson(Map<String, dynamic> json) => DriverUserModel(
        id: json["id"],
        createAt: DateTime.parse(json["create_at"]),
        updateAt: DateTime.parse(json["update_at"]),
        driver: Driver.fromJson(json["driver"]),
        users: List<Driver>.from(json["users"].map((x) => Driver.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "create_at": createAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
        "driver": driver.toJson(),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
    };
}

class Driver {
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
    String password;
    DateTime createAt;
    DateTime updateAt;

    Driver({
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
        required this.password,
        required this.createAt,
        required this.updateAt,
    });

    factory Driver.fromJson(Map<String, dynamic> json) => Driver(
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
        "password": password,
        "create_at": createAt.toIso8601String(),
        "update_at": updateAt.toIso8601String(),
    };
}
