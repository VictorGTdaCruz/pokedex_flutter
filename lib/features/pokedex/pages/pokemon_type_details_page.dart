import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex_flutter/features/pokedex/bloc/pokemon_details_cubit.dart';
import 'package:pokedex_flutter/features/pokedex/bloc/pokemon_type_details_cubit.dart';
import 'package:pokedex_flutter/features/pokedex/components/pokemon_type_card.dart';
import 'package:pokedex_flutter/features/pokedex/repositories/pokemon_details_repository.dart';
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
    return MultiProvider(
      providers: [
        Provider<PokemonTypeDetailsCubit>(create: (context) => PokemonTypeDetailsCubit(PokemonTypeDetailsRepository())),
        Provider<PokemonDetailsCubit>(create: (context) => PokemonDetailsCubit(PokemonDetailsRepository()))
      ],
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
                    return ListView.builder(
                      itemBuilder: (context, position) {

                        final currentPokemon = state.result.pokemons[position];
                        Provider.of<PokemonDetailsCubit>(context).getPokemonDetails(currentPokemon.id);

                        return Card(
                            color: pokemonTypeEnumFrom(state.result.id).backgroundColor,
                            child: Container(
                                margin: const EdgeInsets.all(4),
                                child: BlocBuilder<PokemonDetailsCubit, PokedexState>(
                                  builder: (context, pokemonDetailsState) {

                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                currentPokemon.id.toString(),
                                                style: const TextStyle(color: Colors.white),
                                              ),
                                              Text(
                                                currentPokemon.name,
                                                style: const TextStyle(color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                        if (pokemonDetailsState is SuccessState)
                                          Column(
                                            children: [
                                              for (final type in pokemonDetailsState.result[currentPokemon.id]?.types ?? List.empty())
                                                PokemonTypeCard(type.id)
                                            ],
                                          ),
                                        if (pokemonDetailsState is SuccessState)
                                          Column(
                                            children: [
                                              if (pokemonDetailsState.result[currentPokemon.id]?.sprite != null)
                                                Image.network(
                                                  pokemonDetailsState.result[currentPokemon.id]?.sprite,
                                                  width: 75
                                              ) else
                                                Container(width: 75),
                                            ],
                                          )
                                      ],
                                    );
                                  },
                                )
                            )
                        );
                      },
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