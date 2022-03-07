import 'package:pokedex_flutter/features/pokedex/models/pokemon_type.dart';
import 'package:pokedex_flutter/features/pokedex/repositories/pokemon_repository.dart';

import '../../../arch/podekex_cubit.dart';
import '../models/pokemon_type_details.dart';

class PokemonListByTypeCubit extends PokedexCubit {
  final PokemonRepository repository;
  final PokemonType pokemonType;

  PokemonListByTypeCubit(this.pokemonType, this.repository) {
    getPokemonTypeDetails(pokemonType.id);
  }

  void getPokemonTypeDetails(int id) async {
    manageStatesDuring<PokemonTypeDetails>(() => repository.getPokemonTypeDetails(id));
  }
}
