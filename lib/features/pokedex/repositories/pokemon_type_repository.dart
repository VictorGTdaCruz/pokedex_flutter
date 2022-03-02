import 'package:pokedex_flutter/arch/api.dart';

import '../models/pokemon_type.dart';

class PokemonTypeRepository {
  PokemonTypeRepository();

  Future<List<PokemonType>> getPokemonTypes() async {
    final response = await api.dio.get('type');
    final typeResponse = PokemonType.fromJson(response.data);
    return typeResponse;
  }
}