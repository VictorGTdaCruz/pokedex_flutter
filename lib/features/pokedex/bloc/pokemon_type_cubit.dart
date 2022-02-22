import 'package:pokedex_flutter/arch/podekex_cubit.dart';

import '../repositories/pokemon_type_repository.dart';

class PokemonTypeCubit extends PokedexCubit {
  final PokemonTypeRepository repository;

  PokemonTypeCubit(this.repository);

  void getPokemonTypes() async {
    manageStatesDuring(() => repository.getPokemonTypes());
  }
}