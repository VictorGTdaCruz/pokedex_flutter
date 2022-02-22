import 'package:pokedex_flutter/features/pokedex/repositories/pokemon_type_details_repository.dart';

import '../../../arch/podekex_cubit.dart';

class PokemonTypeDetailsCubit extends PokedexCubit {
  final PokemonTypeDetailsRepository repository;

  PokemonTypeDetailsCubit(this.repository);

  void getPokemonTypeDetails(int id) async {
    manageStatesDuring(() => repository.getPokemonTypeDetails(id));
  }
}