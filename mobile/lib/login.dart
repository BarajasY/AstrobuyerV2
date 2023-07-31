import 'dart:convert';

import 'package:astrobuyer/providers/user_provider.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  String email = "";
  String password = "";
  bool error = false;
  String errorMessage = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> submitLogin() async {
    Uri uri = Uri.http("10.0.2.2:8000", "user/login");
    var passbytes = utf8.encode(passwordController.text);
    var hash = sha256.convert(passbytes).toString();
    final response = await http.post(
      uri,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(
        <String, String>{
          "email": emailController.text,
          "pass": hash,
        },
      ),
    );

    if (response.statusCode == 200) {
      error = false;
      errorMessage = "";
      var decoded = json.decode(response.body);
      if (mounted) {
        context
            .read<UserState>()
            .logIn(decoded["id"], decoded["email"], decoded["username"], true);
        Navigator.of(context).pop();
      }
    } else if (response.statusCode == 409) {
      error = true;
      errorMessage = "Email or Password is incorrect.";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
          backgroundColor: const Color(0xFF000000),
          iconTheme: const IconThemeData(color: Color(0xFFFFFFFF))),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Text(
                "Login",
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w900,
                    fontSize: 25.0),
              ),
              (error
                  ? Text(
                      errorMessage,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 179, 12, 12),
                          fontWeight: FontWeight.w900),
                    )
                  : const Text("")),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
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
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Color.fromARGB(255, 0, 96, 230),
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
                            color: Color.fromARGB(255, 0, 96, 230),
                            fontWeight: FontWeight.w900,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                  onPressed: submitLogin,
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                        color: Color(0xFFFFFFFF), fontWeight: FontWeight.w900),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
