import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  late Future<Astro> astros;

  Future<Astro> getAstros() async {
    final response = await http.get(Uri.parse("http://localhost:8000/astros"));
    if (response.statusCode == 200) {
      return Astro.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch astros.");
    }
  }

  @override
  void initState() {
    super.initState();
    astros = getAstros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Center(child: FutureBuilder<Astro>(builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data!.name);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const Text("Loading...");
      })),
    );
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
