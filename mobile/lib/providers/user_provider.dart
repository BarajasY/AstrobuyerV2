import 'package:flutter/material.dart';

class User {
  int userId = 0;
  bool isLogged = false;
  String userEmail = "";
  String userName = "";
}

class UserState with ChangeNotifier {
  User user = User();

  User get userData => user;

  void logIn(int id, String email, String username) {
    user.userId = id;
    user.userEmail = email;
    user.userName = username;
    user.isLogged = true;
  }
}
