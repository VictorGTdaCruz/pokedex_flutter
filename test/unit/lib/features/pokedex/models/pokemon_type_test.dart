import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_flutter/features/pokedex/models/pokemon_type.dart';

void main() {

  test('Pokemon type deserialization test', () async {
    final result = await rootBundle.loadString('assets/mocks/pokemon_types.json');
    final decoded = json.decode(result);

    final pokemonTypes = PokemonType.fromJson(decoded);
    final expectedTypes = [
      PokemonType(1, 'normal'),
      PokemonType(2, 'fighting'),
      PokemonType(3, 'flying'),
      PokemonType(4, 'poison'),
      PokemonType(5, 'ground'),
      PokemonType(6, 'rock'),
      PokemonType(7, 'bug'),
      PokemonType(8, 'ghost'),
      PokemonType(9, 'steel'),
      PokemonType(10, 'fire'),
      PokemonType(11, 'water'),
      PokemonType(12, 'grass'),
      PokemonType(13, 'electric'),
      PokemonType(14, 'psychic'),
      PokemonType(15, 'ice'),
      PokemonType(16, 'dragon'),
      PokemonType(17, 'dark'),
      PokemonType(18, 'fairy'),
      PokemonType(10001, 'unknown'),
      PokemonType(10002, 'shadow')
    ];

    expect(pokemonTypes, expectedTypes);
  });
}