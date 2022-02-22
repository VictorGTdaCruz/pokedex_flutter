import 'package:dio/dio.dart';

import '../models/pokemon_type.dart';

class PokemonTypeRepository {
  final Dio dio = Dio(
      BaseOptions(
          baseUrl: 'https://pokeapi.co/api/v2/'
      )
  );

  PokemonTypeRepository();

  Future<List<PokemonType>> getPokemonTypes() async {
    final response = await dio.get('type');
    final typeResponse = PokemonType.fromJson(response.data);
    return typeResponse;
  }
}