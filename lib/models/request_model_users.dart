// To parse this JSON data, do
//
//     final reqUser = reqUserFromJson(jsonString);

//import 'dart:convert';

import 'dart:convert';

class ReqUser {
  final String firstName;
  final String lastName;
  final String email;

  ReqUser({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory ReqUser.fromMap(Map<String, dynamic> map) {
    return ReqUser(
      firstName: map["first_name"] as String,
      lastName: map["last_name"] as String,
      email: map["email"] as String,
    );
  }

  Map<String, dynamic> toMap() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
      };

  String toJson() => json.encode(toMap());

  factory ReqUser.fromJson(String source) =>
      ReqUser.fromMap(json.decode(source) as Map<String, dynamic>);
}
