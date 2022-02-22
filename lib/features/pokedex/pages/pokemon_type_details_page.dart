import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex_flutter/features/pokedex/bloc/pokemon_type_details_cubit.dart';
import 'package:pokedex_flutter/features/pokedex/components/pokemon_type_card.dart';
import 'package:pokedex_flutter/features/pokedex/repositories/pokemon_type_details_repository.dart';
import 'package:pokedex_flutter/features/pokemon_type_cache.dart';
import 'package:provider/provider.dart';

import '../../../arch/podekex_cubit.dart';
import '../../ui/widgets/pokedex_empty.dart';
import '../../ui/widgets/pokedex_error.dart';
import '../../ui/widgets/pokedex_loading.dart';
import '../models/pokemon_type.dart';
import '../pokemon_type_enum.dart';

class PokemonTypeDetailsPage extends StatefulWidget {
  const PokemonTypeDetailsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PokemonTypeDetailsPage> createState() => PokemonTypeDetailsPageState();
}

class PokemonTypeDetailsPageState extends State<PokemonTypeDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Provider<PokemonTypeDetailsCubit>(
      create: (context) => PokemonTypeDetailsCubit(PokemonTypeDetailsRepository()),
      child: Scaffold(
        appBar: AppBar(),
        body: Consumer<PokemonTypeCache>(
            builder: (context, cache, _) {
              return BlocBuilder<PokemonTypeDetailsCubit, PokedexState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const PokedexLoading();
                  }

                  if (state is ErrorState) {
                    return PokedexError(() =>
                        BlocProvider.of<PokemonTypeDetailsCubit>(context).getPokemonTypeDetails(cache.pokemonType?.id ?? 0));
                  }

                  if (state is SuccessState) {
                    return ListView(
                      children: [
                        ...state.result.pokemons.expand((pokemon) => [
                          Card(
                            color: pokemonTypeEnumFrom(state.result.id).backgroundColor,
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        pokemon.id.toString(),
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      Text(
                                        pokemon.name,
                                        style: const TextStyle(color: Colors.white),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      PokemonTypeCard(state.result.id)
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SvgPicture.asset(
                                        pokemonTypeEnumFrom(state.result.id).icon,
                                        width: 30,
                                        color: Colors.white,
                                      ),
                                    ],
                                  )
                                ],
                              )
                            )
                          ),
                        ])
                      ],
                    );
                  }

                  return PokedexEmpty(() => BlocProvider.of<PokemonTypeDetailsCubit>(context).getPokemonTypeDetails(cache.pokemonType?.id ?? 0));
                },
              );
            }
        ),
      ),
    );
  }
}