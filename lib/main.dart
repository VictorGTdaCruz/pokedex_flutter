import 'package:flutter/material.dart';
import 'package:pokedex_flutter/arch/api.dart';
import 'package:pokedex_flutter/features/pokedex/pages/pokemon_types_page.dart';
import 'package:provider/provider.dart';

import 'features/pokemon_type_cache.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    api = Api.configure('https://pokeapi.co/api/v2/');
    return Provider(
      create: (_) => PokemonTypeCache(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PokemonTypesPage(),
      ),
    );
  }
}
