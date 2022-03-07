import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex_flutter/features/pokedex/repositories/pokemon_type_repository.dart';

import '../../../../mocks/generator.mocks.dart';

void main() {

  late PokemonTypeRepository repo;

  setUp(() {
    repo = MockPokemonTypeRepository();
  });

  group('PokedexCubit tests', () {
    blocTest<PokemonTypeCubit, PokedexViewState>(
        'WHEN cubit is created THEN should start at empty state',
        build: () {
          return PokemonTypeCubit(repo);
        },
        verify: (cubit) {
          expect(cubit.state, EmptyState());
        }
    );
    //
    blocTest<PokemonTypeCubit, PokedexViewState>(
        'WHEN manageStatesDuring is called THEN should emit loading and success',
        build: () {
          when(repo.getPokemonTypes()).thenAnswer((_) => Future.value([const PokemonType(0, 'water')]));
          return PokemonTypeCubit(repo);
        },
        act: (cubit) => cubit.getPokemonTypes(),
        expect: () =>
        [
          LoadingState(),
          SuccessState<List<PokemonType>>([const PokemonType(0, 'water')])
        ]
    );
    //
    blocTest<PokemonTypeCubit, PokedexViewState>(
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