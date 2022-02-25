import 'package:pokedex_flutter/arch/podekex_cubit.dart';
import 'package:pokedex_flutter/features/pokedex/models/pokemon_type.dart';

import '../repositories/pokemon_type_repository.dart';

class PokemonTypeCubit extends PokedexCubit<List<PokemonType>> {
  final PokemonTypeRepository repository;

  PokemonTypeCubit(this.repository);

  void getPokemonTypes() async {
    manageStatesDuring(() => repository.getPokemonTypes());
  }
}