import 'package:pokedex_flutter/arch/api.dart';

import '../models/pokemon_details.dart';

class PokemonDetailsRepository {
  PokemonDetailsRepository();

  Future<PokemonDetails> getPokemonDetails(int id) async {
    final response = await api.dio.get('pokemon/$id');
    final detailsResponse = PokemonDetails.fromJson(response.data);
    return detailsResponse;
  }
}