import 'dart:async';
import 'dart:convert';

import 'package:astrobuyer/models/astro_model.dart';
import 'package:astrobuyer/providers/user_provider.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';

class Item extends StatefulWidget {
  final int id;
  const Item({super.key, required this.id});

  @override
  State<Item> createState() => _Item();
}

class _Item extends State<Item> {
  late Future<Astro> astro;
  bool success = false;
  bool logged = false;

  @override
  void initState() {
    super.initState();
    astro = getAstro();
    logged = context.read<UserState>().getUserData.isLogged;
  }

  Future<Astro> getAstro() async {
    int itemId = widget.id;
    Uri uri = Uri.http("10.0.2.2:8000", "astros/$itemId");

    final request = await http.get(uri);
    return Astro.fromJson(jsonDecode(request.body));
  }

  Future<void> addCart(int astroId) async {
    int userId = context.read<UserState>().getUserData.userId;
    Uri uri = Uri.http("10.0.2.2:8000", "cart/add");

    final request = await http.post(
      uri,
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, int>{"user_id": userId, "astro_id": astroId}),
    );
    if (request.statusCode == 200) {
      setState(() {
        success = true;
      });
      Timer(const Duration(seconds: 1), () {
        setState(() {
          success = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Astro",
          style:
              TextStyle(color: Color(0xffffffff), fontWeight: FontWeight.w900),
        ),
        iconTheme: const IconThemeData(
          color: Color(0xFFFFFFFF),
        ),
        backgroundColor: const Color(0xff000000),
      ),
      body: Center(
          child: FutureBuilder<Astro>(
        future: astro,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      snapshot.data!.name,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 44, 181, 255),
                          fontWeight: FontWeight.w900,
                          fontSize: 25.0),
                    ),
                  ),
                  Image.network(
                    snapshot.data!.image,
                    width: 300,
                    height: 300,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          snapshot.data!.category,
                          style: const TextStyle(
                              color: Color(0xFF000000),
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "${snapshot.data!.temperature.toString()} ºC",
                          style: const TextStyle(
                              color: Color(0xFFf46263),
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            borderRadius: BorderRadius.circular(10.0)),
                        padding: const EdgeInsets.only(
                            top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
                        child: Text(
                          "\$ ${snapshot.data!.price.toString()}",
                          style: const TextStyle(
                              color: Color(0xff3bae78),
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                  (logged
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                addCart(snapshot.data!.id);
                              },
                              behavior: HitTestBehavior.translucent,
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 40.0, right: 20.0),
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      bottom: 5.0,
                                      left: 15.0,
                                      right: 15.0),
                                  child: const Icon(
                                    IconData(0xe59c,
                                        fontFamily: 'MaterialIcons'),
                                    color: Color(0xffffffff),
                                  )),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 40.0, left: 20.0),
                              decoration: const BoxDecoration(
                                  color: Color(0xff1e2a3c),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              padding: const EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5.0,
                                  left: 15.0,
                                  right: 15.0),
                              child: const Text(
                                "Buy",
                                style: TextStyle(
                                    color: Color(0xff4fafa8),
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20.0),
                              ),
                            )
                          ],
                        )
                      : const Text("")),
                  (success
                      ? Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: const Text(
                            "Item added to your cart.",
                            style: TextStyle(
                                color: Color(0xff4fafa8),
                                fontWeight: FontWeight.w900),
                          ),
                        )
                      : const Text(""))
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else {
            return const CircularProgressIndicator();
          }
        },
      )),
    );
  }
}
