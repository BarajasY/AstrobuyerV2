import 'dart:convert';

import 'package:astrobuyer/models/astro_model.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class Item extends StatefulWidget {
  final int id;
  const Item({super.key, required this.id});

  @override
  State<Item> createState() => _Item();
}

class _Item extends State<Item> {
  Astro? astro;

  Future<void> getAstro() async {
    int itemId = widget.id;
    Uri uri = Uri.http("10.0.2.2:8000", "astros/$itemId");

    final request = await http.get(uri);
    if (request.statusCode == 200) {
      var decode = jsonDecode(request.body);
      astro?.id = decode["id"];
      astro?.name = decode["name"];
      astro?.category = decode["category"];
      astro?.image = decode["image"];
      astro?.price = decode["price"];
      astro?.temperature = decode["temperature"];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff000000),
        ),
        body: Text("wasd"));
  }
}
