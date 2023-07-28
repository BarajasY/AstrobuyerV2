import 'package:flutter/material.dart';
import 'package:mobile/AstroModel.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

class homeBody extends StatefulWidget {
  const homeBody({super.key});

  @override
  State<homeBody> createState() => _homeBody();
}

class _homeBody extends State<homeBody> {
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
                                  Text(
                                    astros![index].name,
                                    style: const TextStyle(
                                        color: Color(0xFF29acf1),
                                        fontWeight: FontWeight.w900),
                                  ),
                                  Text(
                                    astros![index].price.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        color: Color(0xff91f8c7)),
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
