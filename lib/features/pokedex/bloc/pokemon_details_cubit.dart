import 'package:pokedex_flutter/features/pokedex/models/pokemon_details.dart';

import '../../../arch/podekex_cubit.dart';
import '../repositories/pokemon_details_repository.dart';

class PokemonDetailsCubit extends PokedexCubit {
  final PokemonDetailsRepository repository;
  final Map<int, PokemonDetails> detailsMap = {};

  PokemonDetailsCubit(this.repository);

  void getPokemonDetails(int id) async {
    if (detailsMap[id] == null) {
      try {
        emit(LoadingState());
        final result = await repository.getPokemonDetails(id);
        detailsMap[result.id] = result;
        emit(SuccessState<Map<int, PokemonDetails>>(detailsMap));
      } on Exception catch (exception) {
        emit(ErrorState(exception));
      }
    }
  }
}