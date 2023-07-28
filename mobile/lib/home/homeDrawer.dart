import 'package:flutter/material.dart';
import 'package:mobile/profile.dart';

class homeDrawer extends StatelessWidget {
  const homeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF212b35),
      child: ListView(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: TextButton(
              onPressed: () => {
                Scaffold.of(context).closeDrawer(),
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Profile(),
                  ),
                ),
              },
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      IconData(0xe491, fontFamily: 'MaterialIcons'),
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
