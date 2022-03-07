import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/pages/pokemon_list_by_type_page.dart';
import 'package:pokedex_flutter/features/pokedex/repositories/pokemon_repository.dart';
import 'package:provider/provider.dart';

import '../../../arch/podekex_cubit.dart';
import '../../../ui/widgets/pokedex_empty.dart';
import '../../../ui/widgets/pokedex_error.dart';
import '../../../ui/widgets/pokedex_loading.dart';
import '../bloc/pokemon_type_cubit.dart';
import '../components/pokemon_type_card.dart';
import '../models/pokemon_type.dart';

class PokemonTypesPage extends StatelessWidget {
  const PokemonTypesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PokemonTypeCubit(PokemonRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Choose your type!'),
        ),
        body: BlocBuilder<PokemonTypeCubit, PokedexViewState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const PokedexLoading();
            }

            if (state is SuccessState<List<PokemonType>>) {
              return GridView.count(
                childAspectRatio: 3,
                crossAxisCount: 2,
                children: [
                  ...state.result.expand(
                    (type) => [
                      Padding(
                        padding: const EdgeInsets.all(4),
                        child: PokemonTypeCard(
                          type.id,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => PokemonListByTypePage(type)));
                          },
                        ),
                      )
                    ],
                  )
                ],
              );
            }

            if (state is ErrorState) {
              return PokedexError(() => BlocProvider.of<PokemonTypeCubit>(context).getPokemonTypes());
            }

            return const PokedexEmpty();
          },
        ),
      ),
    );
  }
}
