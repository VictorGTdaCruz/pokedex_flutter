import 'package:pokedex_flutter/arch/podekex_cubit.dart';
import 'package:pokedex_flutter/features/pokedex/models/pokemon_details.dart';
import 'package:pokedex_flutter/features/pokedex/repositories/pokemon_repository.dart';

class PokemonDetailCubit extends PokedexCubit {
  final PokemonRepository repo;
  final int pokemonId;
  final Map<int, PokemonDetails> cache = {};

  PokemonDetailCubit(this.pokemonId, this.repo) {
    getPokemonDetails(pokemonId);
  }

  void getPokemonDetails(int id) async {
    manageStatesDuring<PokemonDetails>(() async {
      if (cache.containsKey(id)) {
        return cache[id];
      }

      final detail = await repo.getPokemonDetails(id);
      cache[id] = detail;

      return detail;
    });
  }
}
