// import 'dart:convert';

// UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

// String userModelToJson(UserModel data) => json.encode(data.toJson());

// class UserModel {
//     int id;
//     String firstName;
//     String lastName;
//     String phoneNumber;
//     String companyCode;
//     String post;
//     bool isDriver;
//     bool isAdmin;
//     bool isTell;
//     bool isDriverRole;
//     bool is_cartex;
//     String password;
//     DateTime createAt;
//     DateTime updateAt;
//     String token;

//     UserModel({
//         required this.id,
//         required this.firstName,
//         required this.lastName,
//         required this.phoneNumber,
//         required this.companyCode,
//         required this.post,
//         required this.isDriver,
//         required this.isAdmin,
//         required this.isTell,
//         required this.isDriverRole,
//         required this.is_cartex,
//         required this.password,
//         required this.createAt,
//         required this.updateAt,
//         required this.token,
//     });

//     factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         id: json["id"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         phoneNumber: json["phone_number"],
//         companyCode: json["company_code"],
//         post: json["post"],
//         isDriver: json["is_driver"],
//         isAdmin: json["is_admin"],
//         isTell: json["is_tell"],
//         isDriverRole: json["is_driver_role"],
//         is_cartex: json["is_cartex"],
//         password: json["password"],
//         createAt: DateTime.parse(json["create_at"]),
//         updateAt: DateTime.parse(json["update_at"]),
//         token: json["token"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "first_name": firstName,
//         "last_name": lastName,
//         "phone_number": phoneNumber,
//         "company_code": companyCode,
//         "post": post,
//         "is_driver": isDriver,
//         "is_admin": isAdmin,
//         "is_tell": isTell,
//         "is_driver_role": isDriverRole,
//         "is_cartex": is_cartex,
//         "password": password,
//         "create_at": createAt.toIso8601String(),
//         "update_at": updateAt.toIso8601String(),
//         "token": token,
//     };
// }
