import 'package:flutter/material.dart';
import 'package:mobile/astroModel.dart';

class AstroMainUI extends StatefulWidget {
  final Astro? astro;

  const AstroMainUI({Key? key, this.astro}) : super(key: key);

  @override
  State<AstroMainUI> createState() => _AstroMainUI();
}

class _AstroMainUI extends State<AstroMainUI> {
  late Astro? astro;

  @override
  void initState() {
    super.initState();
    astro = widget.astro;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: ListView(
        children: <Widget>[Image.network(astro?.image ?? "")],
      ),
    );
  }
}
