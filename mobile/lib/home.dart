import 'package:flutter/material.dart';
import 'package:mobile/cart.dart';
import 'package:mobile/home/home_body.dart';
import 'package:mobile/home/home_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  bool menu = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const Cart(),
              ),
            ),
            icon: const Icon(
              IconData(0xe59c, fontFamily: 'MaterialIcons'),
              color: Color(0xFFFFFFFF),
            ),
          )
        ],
        backgroundColor: const Color(0xFF000000),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const Icon(
              Icons.menu_rounded,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ),
      drawer: const HomeDrawer(),
      body: const HomeBody(),
    );
  }
}
