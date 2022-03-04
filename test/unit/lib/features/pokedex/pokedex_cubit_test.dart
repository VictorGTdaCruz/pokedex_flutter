import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pokedex_flutter/arch/podekex_cubit.dart';
import 'package:pokedex_flutter/features/pokedex/bloc/pokemon_type_cubit.dart';
import 'package:pokedex_flutter/features/pokedex/models/pokemon_type.dart';
import 'package:pokedex_flutter/features/pokedex/repositories/pokemon_type_repository.dart';

import '../../../../mocks/generator.mocks.dart';

void main() {

  late PokemonTypeRepository repo;

  setUp(() {
    repo = MockPokemonTypeRepository();
  });

  group('PokedexCubit tests', () {
    blocTest<PokemonTypeCubit, PokedexState>(
        'WHEN cubit is created THEN should start at empty state',
        build: () {
          return PokemonTypeCubit(repo);
        },
        verify: (cubit) {
          expect(cubit.state, EmptyState());
        }
    );

    blocTest<PokemonTypeCubit, PokedexState>(
        'WHEN manageStatesDuring is called THEN should emit loading and success',
        build: () {
          when(repo.getPokemonTypes()).thenAnswer((_) => Future.value([PokemonType(0, 'water')]));
          return PokemonTypeCubit(repo);
        },
        act: (cubit) => cubit.getPokemonTypes(),
        expect: () =>
        [
          LoadingState(),
          SuccessState<List<PokemonType>>([PokemonType(0, 'water')])
        ]
    );

    blocTest<PokemonTypeCubit, PokedexState>(
        'WHEN manageStatesDuring is called with exception THEN should emit error',
        build: () {
          when(repo.getPokemonTypes()).thenAnswer((_) => Future.error(Exception()));
          return PokemonTypeCubit(repo);
        },
        act: (cubit) => cubit.getPokemonTypes(),
        expect: () =>
        [
          LoadingState(),
          ErrorState(Exception())
        ]
    );
  });
}