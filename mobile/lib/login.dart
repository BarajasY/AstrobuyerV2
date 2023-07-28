import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _Login();
}

class _Login extends State<Login> {
  String email = "";
  String password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                width: 250,
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
/*               TextButton(onPressed: , child: Text("Submit")) */
            ],
          ),
        ),
      ),
    );
  }
}
