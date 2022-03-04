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
      const PokemonType(1, 'normal'),
      const PokemonType(2, 'fighting'),
      const PokemonType(3, 'flying'),
      const PokemonType(4, 'poison'),
      const PokemonType(5, 'ground'),
      const PokemonType(6, 'rock'),
      const PokemonType(7, 'bug'),
      const PokemonType(8, 'ghost'),
      const PokemonType(9, 'steel'),
      const PokemonType(10, 'fire'),
      const PokemonType(11, 'water'),
      const PokemonType(12, 'grass'),
      const PokemonType(13, 'electric'),
      const PokemonType(14, 'psychic'),
      const PokemonType(15, 'ice'),
      const PokemonType(16, 'dragon'),
      const PokemonType(17, 'dark'),
      const PokemonType(18, 'fairy'),
      const PokemonType(10001, 'unknown'),
      const PokemonType(10002, 'shadow')
    ];

    expect(pokemonTypes, expectedTypes);
  });
}