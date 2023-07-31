import 'package:flutter/material.dart';
import 'package:astrobuyer/models/astro_model.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBody();
}

class _HomeBody extends State<HomeBody> {
  List<Astro>? astros;

  @override
  void initState() {
    super.initState();
    getAstros();
  }

  Future<void> getAstros() async {
    Uri uri = Uri.http("10.0.2.2:8000", "/astros");
    List<Astro> test = [];

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
        test.add(astro);
      }
      astros = test;
      setState(() {});
    } else {
      throw Exception("Failed to fetch astros.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff000000), Color(0xff042b4a)],
            stops: [0.6, 1],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: const Text(
                "Check our Stock!",
                style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w900,
                    fontSize: 20.0),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisExtent: 200,
                    maxCrossAxisExtent: 300,
                    childAspectRatio: 1,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 10),
                itemCount: astros?.length,
                itemBuilder: (BuildContext context, int index) {
                  if (astros == null) {
                    return const CircularProgressIndicator();
                  } else {
                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            border: Border(
                              top: BorderSide(
                                color: Color(0xFFFFFFFF),
                              ),
                              left: BorderSide(
                                color: Color(0xFFFFFFFF),
                              ),
                              bottom: BorderSide(
                                color: Color(0xFFFFFFFF),
                              ),
                              right: BorderSide(
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Image.network(
                                astros![index].image,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 10.0),
                                    padding: const EdgeInsets.only(
                                        top: 2.0,
                                        left: 15.0,
                                        right: 15.0,
                                        bottom: 2.0),
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color(0xff222222),
                                            Color(0xff2c3e50)
                                          ]),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    child: Text(
                                      astros![index].name,
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 44, 181, 255),
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 10.0),
                                    padding: const EdgeInsets.only(
                                        top: 2.0,
                                        left: 15.0,
                                        right: 15.0,
                                        bottom: 2.0),
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color(0xff222222),
                                            Color.fromARGB(255, 24, 34, 43)
                                          ]),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                    child: Text(
                                      astros![index].price.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Color(0xff91f8c7)),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
