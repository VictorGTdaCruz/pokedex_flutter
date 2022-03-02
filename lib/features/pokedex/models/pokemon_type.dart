import 'package:pokedex_flutter/features/pokedex/utils/pokedex_formatter.dart';

class PokemonType {
  final int id;
  final String name;

  PokemonType(this.id, this.name);

  @override
  String toString() => '{name: $id, id: $name}';

  static List<PokemonType> fromJson(Map<String, dynamic> json) {
    final pokemonTypeResponse = json['results'];
    return pokemonTypeResponse.map<PokemonType>((element) {
        final url = element['url'].toString();
        return PokemonType(PokedexFormatter.getIdFromTypeUrl(url), element['name'].toString());
    }).toList();
  }
}