import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:mobile/AstroMainUI.dart';
import 'package:mobile/astroModel.dart';
import 'package:mobile/profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  bool menu = false;

  @override
  Widget build(BuildContext context) {
    void toggleMenu() {
      setState(() {
        menu = !menu;
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        leading: Builder(
            builder: (context) => IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(
                  Icons.menu_rounded,
                  color: Color(0xFFFFFFFF),
                ))),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF212b35),
        child: ListView(
          children: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const Profile())),
              child: const Text(
                "Profile",
                style: TextStyle(
                    color: Color(0xFFFFFFFF), fontWeight: FontWeight.w900),
              ),
            )
          ],
        ),
      ),
      body: Center(
          child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                colors: [Color(0xff000000), Color(0xff042b4a)],
                stops: [0.6, 1],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
              child: FutureBuilder(
                  future: getAstros(),
                  builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (ctx, index) =>
                              AstroMainUI(astro: snapshot.data[index]));
                      /* Text(
                          snapshot.data[index].name,
                          style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w900),
                        ), */
                    }
                  }))),
    );
  }
}

Future<List<Astro>> getAstros() async {
  List<Astro> astros = [];
  Uri uri = Uri.http("10.0.2.2:8000", "/astros");

  final response = await http.get(uri);
  if (response.statusCode == 200) {
    var decoded = json.decode(response.body);
    for (var element in decoded) {
      Astro astro = Astro(
          id: element["id"],
          name: element["name"],
          price: element["price"],
          category: element["category"],
          temperature: element["temperature"],
          image: element["image"]);
      astros.add(astro);
    }
    return astros;
  } else {
    throw Exception("Failed to fetch astros.");
  }
}
