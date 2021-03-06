import 'package:pokedex_flutter/features/pokedex/utils/pokedex_formatter.dart';

class PokemonTypeDetails {
  PokemonTypeDetails(this.id, this.name, this.pokemons);

  final int id;
  final String name;
  final List<Pokemon> pokemons;

  @override
  String toString() => '{name: $name, id: $id}';

  factory PokemonTypeDetails.fromJson(Map<String, dynamic> json) {
    final test = json['pokemon'];
    final pokemons = test.map<Pokemon>((element) => Pokemon.fromJson(element)).toList();
    return PokemonTypeDetails(json['id'], json['name'], pokemons);
  }
}

class Pokemon {
  Pokemon(this.id, this.name);

  final int id;
  final String name;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    final pokemon = json['pokemon'];
    final url = pokemon['url'];
    return Pokemon(PokedexFormatter.getIdFromPokemonUrl(url), pokemon['name']);
  }
}