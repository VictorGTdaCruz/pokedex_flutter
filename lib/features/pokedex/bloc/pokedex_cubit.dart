import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/pokemon_type.dart';
import '../repositories/pokedex_repository.dart';

class PokedexCubit extends Cubit<PokemonTypeState> {
  final PokedexRepository repo;

  PokedexCubit(this.repo) : super(InitialState());

  void getPokemonTypes() async {
    try {
      emit(LoadingState());
      final types = await repo.getPokemonTypes();
      emit(SuccessState(types));
    } catch (ex) {
      emit(ErrorState());
    }
  }
}

abstract class PokemonTypeState extends Equatable {}

class InitialState extends PokemonTypeState {
  @override
  List<PokemonType> get props => [];
}
class LoadingState extends PokemonTypeState {
  @override
  List<PokemonType> get props => [];
}
class ErrorState extends PokemonTypeState {
  @override
  List<PokemonType> get props => [];
}
class SuccessState extends PokemonTypeState {
  SuccessState(this.types);

  final List<PokemonType> types;

  @override
  List<PokemonType> get props => types;
}