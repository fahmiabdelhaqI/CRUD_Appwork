// To parse this JSON data, do

//import 'dart:convert';

class UsersModel {
  final String module;
  final List<Users> data;
  final int dataCount;
  final Params params;

  UsersModel({
    required this.module,
    required this.data,
    required this.dataCount,
    required this.params,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        module: json["module"],
        data: List<Users>.from(json["data"].map((x) => Users.fromJson(x))),
        dataCount: json["data_count"],
        params: Params.fromJson(json["params"]),
      );

  Map<String, dynamic> toJson() => {
        "module": module,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "data_count": dataCount,
        "params": params.toJson(),
      };
}

class Users {
  final String firstName;
  final String lastName;
  final String email;
  final int id;

  Users({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.id,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "id": id,
      };
}

class Params {
  Params();

  factory Params.fromJson(Map<String, dynamic> json) => Params();

  Map<String, dynamic> toJson() => {};
}
