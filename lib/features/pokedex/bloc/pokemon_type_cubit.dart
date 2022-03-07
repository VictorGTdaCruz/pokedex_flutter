import 'package:pokedex_flutter/arch/podekex_cubit.dart';
import 'package:pokedex_flutter/features/pokedex/models/pokemon_type.dart';
import 'package:pokedex_flutter/features/pokedex/repositories/pokemon_repository.dart';

class PokemonTypeCubit extends PokedexCubit {
  final PokemonRepository repository;

  PokemonTypeCubit(this.repository) {
    getPokemonTypes();
  }

  void getPokemonTypes() {
    manageStatesDuring<List<PokemonType>>(() => repository.getPokemonTypes());
  }
}
