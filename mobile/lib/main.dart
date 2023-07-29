import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Astrobuyer/home.dart';
import 'package:Astrobuyer/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => UserState()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
      home: const MyHomePage(title: 'Astrobuyer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Home()));
    });

    return const Scaffold(
      backgroundColor: Color(0xFF000000),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedPositioned(
              top: 20.0,
              duration: Duration(seconds: 2),
              child: Text(
                'Astrobuyer',
                style: TextStyle(
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset(0.0, 0.0),
                          blurRadius: 60.0,
                          color: Color(0xFF29acf1))
                    ],
                    fontWeight: FontWeight.w900,
                    fontSize: 40.0,
                    color: Color(0xFF29acf1)),
              ),
            ),
            Icon(
              IconData(0xe5f9, fontFamily: "MaterialIcons"),
              size: 40.0,
              color: Color(0xFFFFFFFF),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
