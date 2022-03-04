import 'package:equatable/equatable.dart';
import 'package:pokedex_flutter/features/pokedex/utils/pokedex_formatter.dart';

class PokemonType extends Equatable {
  final int id;
  final String name;

  PokemonType(this.id, this.name);

  @override
  String toString() => '{id: $id, name: $name}';

  static List<PokemonType> fromJson(Map<String, dynamic> json) {
    final pokemonTypeResponse = json['results'];
    return pokemonTypeResponse.map<PokemonType>((element) {
        final url = element['url'].toString();
        return PokemonType(PokedexFormatter.getIdFromTypeUrl(url), element['name'].toString());
    }).toList();
  }

  @override
  List<Object?> get props => [id, name];
}