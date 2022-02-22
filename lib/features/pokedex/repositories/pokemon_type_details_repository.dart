import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/pokemon_type_details.dart';

class PokemonTypeDetailsRepository {
  final Dio dio = Dio(
      BaseOptions(
          baseUrl: 'https://pokeapi.co/api/v2/'
      )
  );

  PokemonTypeDetailsRepository();

  Future<PokemonTypeDetails> getPokemonTypeDetails(int id) async {
    final response = await dio.get('type/$id');
    print(response);
    final typeDetailsResponse = PokemonTypeDetails.fromJson(response.data);
    return typeDetailsResponse;
  }
}