import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/pokemon_details.dart';
import '../models/pokemon_type_details.dart';

class PokemonDetailsRepository {
  final Dio dio = Dio(
      BaseOptions(
          baseUrl: 'https://pokeapi.co/api/v2/'
      )
  );

  PokemonDetailsRepository();

  Future<PokemonDetails> getPokemonDetails(int id) async {
    final response = await dio.get('pokemon/$id');
    final detailsResponse = PokemonDetails.fromJson(response.data);
    return detailsResponse;
  }
}