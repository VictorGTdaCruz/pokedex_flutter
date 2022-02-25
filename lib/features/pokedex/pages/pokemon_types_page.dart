import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/pages/pokemon_type_details_page.dart';
import 'package:provider/provider.dart';

import '../../../arch/podekex_cubit.dart';
import '../../pokemon_type_cache.dart';
import '../../ui/widgets/pokedex_empty.dart';
import '../../ui/widgets/pokedex_error.dart';
import '../../ui/widgets/pokedex_loading.dart';
import '../bloc/pokemon_type_cubit.dart';
import '../components/pokemon_type_card.dart';
import '../models/pokemon_type.dart';
import '../repositories/pokemon_type_repository.dart';

class PokemonTypesPage extends StatefulWidget {
  const PokemonTypesPage({Key? key}) : super (key: key);

  @override
  State<PokemonTypesPage> createState() => _PokemonTypesPageState();
}

class _PokemonTypesPageState extends State<PokemonTypesPage> {

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PokemonTypeCubit(PokemonTypeRepository())..getPokemonTypes(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Choose your type!'),
        ),
        body: BlocBuilder<PokemonTypeCubit, PokedexState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const PokedexLoading();
            }

            if (state is SuccessState<List<PokemonType>>) {
              return GridView.count(
                childAspectRatio: 3,
                crossAxisCount: 2,
                children: [
                  ...state.result.expand((type) => [
                    Padding(
                        padding: const EdgeInsets.all(4),
                        child: PokemonTypeCard(
                          type.id,
                          onPressed: () {
                            Provider.of<PokemonTypeCache>(context, listen: false).pokemonType = type;
                            Navigator.push(context, MaterialPageRoute(
                                builder: (_) => const PokemonTypeDetailsPage()
                            ));
                          }
                        )
                    )
                  ])
                ],
              );
            }

            if (state is ErrorState) {
              return PokedexError(() => BlocProvider.of<PokemonTypeCubit>(context).getPokemonTypes());
            }

            return PokedexEmpty(() => BlocProvider.of<PokemonTypeCubit>(context).getPokemonTypes());
          },
        ),
      ),
    );
  }
}