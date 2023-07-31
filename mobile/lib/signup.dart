import 'dart:convert';

import 'package:astrobuyer/providers/user_provider.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _Signup();
}

class _Signup extends State<Signup> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool error = false;
  String errorMessage = "";

  Future<void> submitSignup() async {
    var passbytes = utf8.encode(passwordController.text);
    var hash = sha256.convert(passbytes).toString();
    Uri uri = Uri.http("10.0.2.2:8000", "/user/create");

    final response = await http.post(
      uri,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{
          "username": usernameController.text,
          "email": emailController.text,
          "pass": hash
        },
      ),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      if (mounted) {
        context
            .read<UserState>()
            .logIn(json["id"], json["email"], json["username"], true);
        Navigator.of(context).pop();
      }
    } else {
      error = true;
      errorMessage = "Could not signup your account.";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        iconTheme: const IconThemeData(
          color: Color(0xFFFFFFFF),
        ),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Text(
                "Signup",
                style: TextStyle(
                    color: Color(0xFFFFFFFF), fontWeight: FontWeight.w900),
              ),
              Container(
                width: 300,
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: TextField(
                          style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w900,
                              fontSize: 15.0),
                          controller: usernameController,
                          decoration: const InputDecoration(
                            labelText: "Username",
                            labelStyle: TextStyle(
                              color: Color(0xffd63147),
                              fontWeight: FontWeight.w900,
                              fontSize: 15.0,
                            ),
                          ),
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: TextField(
                        style: const TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontWeight: FontWeight.w900,
                            fontSize: 15.0),
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Color(0xffd63147),
                            fontWeight: FontWeight.w900,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: TextField(
                          obscureText: true,
                          style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w900,
                              fontSize: 15.0),
                          controller: passwordController,
                          decoration: const InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                              color: Color(0xffd63147),
                              fontWeight: FontWeight.w900,
                              fontSize: 15.0,
                            ),
                          )),
                    ),
                    TextButton(
                      onPressed: submitSignup,
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color: Color(0xffffffff),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
