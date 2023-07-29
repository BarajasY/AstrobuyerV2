import 'package:flutter/material.dart';
import 'package:mobile/login.dart';

class HomeDrawerLgOn extends StatelessWidget {
  const HomeDrawerLgOn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              IconData(0xe092,
                  fontFamily: 'MaterialIcons', matchTextDirection: true),
              color: Color(0xFFFFFFFF),
            ),
          ),
          TextButton(
            onPressed: () => {
              Scaffold.of(context).closeDrawer(),
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ),
              ),
            },
            child: const Text(
              "Logout",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
