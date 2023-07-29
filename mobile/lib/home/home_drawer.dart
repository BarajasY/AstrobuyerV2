import 'package:flutter/material.dart';
import 'package:mobile/home/home_drawer_lgoff.dart';
import 'package:mobile/home/home_drawer_lgon.dart';
import 'package:mobile/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawer();
}

class _HomeDrawer extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF212b35),
      child: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                context.read<UserState>().userData.isLogged
                    ? const HomeDrawerLgOn()
                    : const HomeDrawerLgOff()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
