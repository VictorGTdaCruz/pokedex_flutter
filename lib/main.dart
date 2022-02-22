import 'package:flutter/material.dart';
import 'package:pokedex_flutter/features/pokedex/pages/pokemon_types_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PokemonTypesPage('Flutter Demo Home Page'),
    );
  }
}
