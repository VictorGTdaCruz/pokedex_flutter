import 'package:flutter/material.dart';
import 'package:pokedex_flutter/features/pokedex/pages/pokemon_types_page.dart';
import 'package:pokedex_flutter/features/pokemon_type_cache.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<PokemonTypeCache>(
      create: (_) => PokemonTypeCache(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PokemonTypesPage('Flutter Demo Home Page'),
      )
    );
  }
}
