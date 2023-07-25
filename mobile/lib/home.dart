import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF000000),
      body: Center(
        child: Text(
          "Hola",
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
      ),
    );
  }
}
