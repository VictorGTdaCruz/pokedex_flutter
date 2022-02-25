import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/bloc/pokemon_details_cubit.dart';
import 'package:pokedex_flutter/features/pokedex/bloc/pokemon_type_details_cubit.dart';
import 'package:pokedex_flutter/features/pokedex/components/pokemon_type_card.dart';
import 'package:pokedex_flutter/features/pokedex/repositories/pokemon_details_repository.dart';
import 'package:pokedex_flutter/features/pokedex/repositories/pokemon_type_details_repository.dart';
import 'package:pokedex_flutter/features/pokedex/utils/pokedex_formatter.dart';
import 'package:pokedex_flutter/features/pokemon_type_cache.dart';
import 'package:provider/provider.dart';

import '../../../arch/podekex_cubit.dart';
import '../../ui/widgets/pokedex_empty.dart';
import '../../ui/widgets/pokedex_error.dart';
import '../../ui/widgets/pokedex_loading.dart';
import '../models/pokemon_details.dart';
import '../models/pokemon_type_details.dart';
import '../pokemon_type_enum.dart';

class PokemonTypeDetailsPage extends StatefulWidget {
  const PokemonTypeDetailsPage({Key? key}) : super(key: key);

  @override
  State<PokemonTypeDetailsPage> createState() => PokemonTypeDetailsPageState();
}

class PokemonTypeDetailsPageState extends State<PokemonTypeDetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonTypeCache>(
      builder: (context, cache, _) {
        return MultiProvider(
          providers: [
            Provider(create: (context) => PokemonTypeDetailsCubit(PokemonTypeDetailsRepository())
              ..getPokemonTypeDetails(cache.pokemonType?.id ?? 0)),
            Provider(create: (context) => PokemonDetailsCubit(PokemonDetailsRepository()))
          ],
          child: Scaffold(
            appBar: AppBar(
              title: Text('${cache.pokemonType?.name.formatName()} pokémons!')
            ),
            body: BlocBuilder<PokemonTypeDetailsCubit, PokedexState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const PokedexLoading();
                }

                if (state is SuccessState<PokemonTypeDetails>) {
                  return PokemonListWidget(state.result.pokemons, state.result.id);
                }

                if (state is ErrorState) {
                  return PokedexError(() =>
                      BlocProvider.of<PokemonTypeDetailsCubit>(context)
                          .getPokemonTypeDetails(cache.pokemonType?.id ?? 0));
                }

                return PokedexEmpty(() =>
                    BlocProvider.of<PokemonTypeDetailsCubit>(context)
                        .getPokemonTypeDetails(cache.pokemonType?.id ?? 0));
              },
            )
          )
        );
      }
    );
  }
}

class PokemonListWidget extends StatelessWidget {
  final List<Pokemon> pokemonList;
  final int typeId;

  PokemonListWidget(this.pokemonList, this.typeId);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pokemonList.length,
      itemBuilder: (context, position) {
        final currentPokemon = pokemonList[position];
        Provider.of<PokemonDetailsCubit>(context).getPokemonDetails(currentPokemon.id);
        return PokemonListItemWidget(currentPokemon, pokemonTypeEnumFrom(typeId).backgroundColor);
      },
    );
  }
}

class PokemonListItemWidget extends StatefulWidget {
  Pokemon currentPokemon;
  Color pokemonTypeBackgroundColor;

  PokemonListItemWidget(this.currentPokemon, this.pokemonTypeBackgroundColor);

  @override
  State<PokemonListItemWidget> createState() => _PokemonListItemWidgetState();
}

class _PokemonListItemWidgetState extends State<PokemonListItemWidget> {
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isOpened = !isOpened;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical : 2.0, horizontal: 4.0),
        child: Card(
            color: widget.pokemonTypeBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: BlocBuilder<PokemonDetailsCubit, PokedexState>(
                builder: (context, state) {
                  return AnimatedSize(
                    duration: const Duration(milliseconds: 100),
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 36),
                              child: Text(
                                '${widget.currentPokemon.id.formatId()}\n${widget.currentPokemon.name.formatName()}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            if (state is SuccessState<Map<int, PokemonDetails>> && state.result[widget.currentPokemon.id]?.types != null)
                              Column(
                                children: [
                                  ...?state.result[widget.currentPokemon.id]?.types.map((type) {
                                    return PokemonTypeCard(type.id);
                                  })
                                ],
                              ),
                            if (state is SuccessState<Map<int, PokemonDetails>> && state.result[widget.currentPokemon.id]?.sprite != null)
                              Image.network(
                                  state.result[widget.currentPokemon.id]?.sprite ?? '',
                                  height: 75
                              ),
                          ],
                        ),
                        if (isOpened && state is SuccessState<Map<int, PokemonDetails>> && state.result[widget.currentPokemon.id]?.stats != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  const Text(
                                      'Height',
                                      style: TextStyle(color: Colors.white)
                                  ),
                                  Text(
                                      state.result[widget.currentPokemon.id]?.height.formatHeight() ?? '',
                                      style: const TextStyle(color: Colors.white)
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                      'Weight',
                                      style: TextStyle(color: Colors.white)
                                  ),
                                  Text(
                                      state.result[widget.currentPokemon.id]?.weight.formatWeight() ?? '',
                                      style: const TextStyle(color: Colors.white)
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  const Text(
                                      'Base Stats',
                                      style: TextStyle(color: Colors.white)
                                  ),
                                  const SizedBox(height: 10),
                                  ...?state.result[widget.currentPokemon.id]?.stats.map((stat) {
                                    return Text(
                                        '${stat.name}: ${stat.baseStat.toString()}',
                                        style: const TextStyle(color: Colors.white)
                                    );
                                  })
                                ],
                              )
                            ],
                          )
                      ],
                    ),
                  );
                },
              ),
            )
        ),
      ),
    );
  }
}

