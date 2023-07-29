import 'package:flutter/material.dart';

class User {
  int userId = 0;
  bool isLogged = false;
  String userEmail = "";
  String userName = "";
}

class UserState extends ChangeNotifier {
  User user = User();

  User get getUserData => user;

  void logIn(int id, String email, String username, bool logged) {
    user.userId = id;
    user.userEmail = email;
    user.userName = username;
    user.isLogged = logged;
    notifyListeners();
  }

  void logOut() {
    user.userId = 0;
    user.userEmail = "";
    user.userName = "";
    user.isLogged = false;
    notifyListeners();
  }
}
