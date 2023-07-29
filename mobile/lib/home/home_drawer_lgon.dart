import 'package:flutter/material.dart';
import 'package:Astrobuyer/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeDrawerLgOn extends StatelessWidget {
  const HomeDrawerLgOn({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(builder: (context, provider, child) {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  provider.getUserData.userName,
                  style: const TextStyle(
                      fontSize: 20.0,
                      color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    IconData(0xe3b3, fontFamily: 'MaterialIcons'),
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                TextButton(
                  onPressed: () => {
                    Scaffold.of(context).closeDrawer(),
                    context.read<UserState>().logOut()
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
          )
        ],
      );
    });
  }
}
