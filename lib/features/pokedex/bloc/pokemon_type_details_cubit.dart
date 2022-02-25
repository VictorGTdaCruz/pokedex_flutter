import 'package:pokedex_flutter/features/pokedex/repositories/pokemon_type_details_repository.dart';

import '../../../arch/podekex_cubit.dart';
import '../models/pokemon_type_details.dart';

class PokemonTypeDetailsCubit extends PokedexCubit<PokemonTypeDetails> {
  final PokemonTypeDetailsRepository repository;

  PokemonTypeDetailsCubit(this.repository);

  void getPokemonTypeDetails(int id) async {
    manageStatesDuring(() => repository.getPokemonTypeDetails(id));
  }
}