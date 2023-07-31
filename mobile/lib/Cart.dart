import 'dart:convert';

import 'package:astrobuyer/models/cart_model.dart';
import 'package:astrobuyer/providers/user_provider.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _Cart();
}

class _Cart extends State<Cart> {
  List<CartAstro> astros = [];
  int total = 0;

  @override
  void initState() {
    super.initState();
    getCart();
  }

  Future<void> getCart() async {
    int userId = context.read<UserState>().getUserData.userId;
    List<CartAstro> temp = [];

    Uri uri = Uri.http("10.0.2.2:8000", "/cart/get/$userId");

    var request = await http.get(uri);
    if (request.statusCode == 200) {
      var decoded = jsonDecode(request.body);
      for (var item in decoded) {
        CartAstro cartAstro = CartAstro(
          id: item["id"],
          name: item["name"],
          price: item["price"],
          category: item["category"],
          temperature: item["temperature"],
          image: item["image"],
          itemId: item["item_id"],
        );
        total += cartAstro.price;
        temp.add(cartAstro);
      }
      astros = temp;
      setState(() {});
    } else {
      throw Exception("Could not load cart.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: const Color(0xFF000000),
        iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: astros.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    if (astros.isEmpty) {
                      return const CircularProgressIndicator();
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xffffffff),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8.0))),
                        margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Row(
                          children: [
                            Image.network(
                              astros[index].image,
                              width: 100,
                              height: 100,
                            ),
                            Container(
                              width: 150,
                              margin: const EdgeInsets.only(left: 10.0),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      astros[index].name,
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 44, 181, 255),
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      astros[index].category,
                                      style: const TextStyle(
                                          color: Color(0xffd63147),
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${astros[index].temperature.toString()} ºCelsius",
                                      style: const TextStyle(
                                          color: Color(0xffffffff),
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "\$ ${astros[index].price.toString()}",
                                      style: const TextStyle(
                                          color: Color(0xff36dbb1),
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
              Text(
                "\$ $total",
                style: const TextStyle(
                    color: Color(0xff36dbb1), fontWeight: FontWeight.w900),
              )
            ],
          ),
        ),
      ),
    );
  }
}
