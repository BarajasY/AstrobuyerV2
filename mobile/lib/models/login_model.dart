import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  late int? id;
  late String? username;
  late String? email;

  LoginModel({this.id, this.username, this.email});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        id: json["id"], username: json["username"], email: json["email"]);
  }
}
