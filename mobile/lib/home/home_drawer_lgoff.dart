import 'package:flutter/material.dart';
import 'package:astrobuyer/login.dart';
import 'package:astrobuyer/signup.dart';

class HomeDrawerLgOff extends StatelessWidget {
  const HomeDrawerLgOff({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                  "Login",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  IconData(0xe491, fontFamily: 'MaterialIcons'),
                  color: Color(0xFFFFFFFF),
                ),
              ),
              TextButton(
                onPressed: () => {
                  Scaffold.of(context).closeDrawer(),
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const Signup(),
                    ),
                  ),
                },
                child: const Text(
                  "Signup",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w900),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
