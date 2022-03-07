import 'package:pokedex_flutter/features/pokedex/models/pokemon_details.dart';
import 'package:pokedex_flutter/features/pokedex/models/pokemon_type.dart';

import '../../../arch/api.dart';
import '../models/pokemon_type_details.dart';

class PokemonRepository {
  PokemonRepository();

  Future<PokemonTypeDetails> getPokemonTypeDetails(int id) async {
    final response = await api.dio.get('type/$id');
    final typeDetailsResponse = PokemonTypeDetails.fromJson(response.data);
    return typeDetailsResponse;
  }

  Future<PokemonDetails> getPokemonDetails(int id) async {
    final response = await api.dio.get('pokemon/$id');
    final detailsResponse = PokemonDetails.fromJson(response.data);
    return detailsResponse;
  }

  Future<List<PokemonType>> getPokemonTypes() async {
    final response = await api.dio.get('type');
    final typeResponse = PokemonType.fromJson(response.data);
    return typeResponse;
  }
}
