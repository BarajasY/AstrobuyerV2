import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

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
        menu = true;
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF000000),
        actions: <Widget>[
          IconButton(
              onPressed: toggleMenu,
              icon: const Icon(
                IconData(0xf1c3, fontFamily: 'MaterialIcons'),
                size: 30.0,
                color: Color(0xFFFFFFFF),
              ))
        ],
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
                        itemBuilder: (ctx, index) => Text(
                          snapshot.data[index].name,
                          style: const TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.w900),
                        ),
                      );
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

class Astro {
  final int id;
  final String name;
  final int price;
  final String category;
  final int temperature;
  final String image;

  const Astro(
      {required this.id,
      required this.name,
      required this.price,
      required this.category,
      required this.temperature,
      required this.image});

  factory Astro.fromJson(Map<String, dynamic> json) {
    return Astro(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        category: json["category"],
        temperature: json["temperature"],
        image: json["image"]);
  }
}
