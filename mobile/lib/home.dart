import 'package:flutter/material.dart';
import 'package:Astrobuyer/cart.dart';
import 'package:Astrobuyer/home/home_body.dart';
import 'package:Astrobuyer/home/home_drawer.dart';
import 'package:Astrobuyer/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        actions: [
          Consumer<UserState>(builder: (context, provider, child) {
            return (provider.getUserData.isLogged
                ? IconButton(
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
                : const Text(""));
          })
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
