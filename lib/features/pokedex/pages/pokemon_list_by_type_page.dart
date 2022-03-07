import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_flutter/features/pokedex/bloc/pokemon_detail_cubit.dart';
import 'package:pokedex_flutter/features/pokedex/bloc/pokemon_list_by_type_cubit.dart';
import 'package:pokedex_flutter/features/pokedex/components/pokemon_type_card.dart';
import 'package:pokedex_flutter/features/pokedex/models/pokemon_type.dart';
import 'package:pokedex_flutter/features/pokedex/repositories/pokemon_repository.dart';
import 'package:pokedex_flutter/features/pokedex/utils/pokedex_formatter.dart';
import 'package:provider/provider.dart';

import '../../../arch/podekex_cubit.dart';
import '../../../ui/widgets/pokedex_empty.dart';
import '../../../ui/widgets/pokedex_error.dart';
import '../../../ui/widgets/pokedex_loading.dart';
import '../models/pokemon_details.dart';
import '../models/pokemon_type_details.dart';
import '../pokemon_type_enum.dart';

class PokemonListByTypePage extends StatelessWidget {
  final PokemonType pokemonType;

  const PokemonListByTypePage(this.pokemonType, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (context) => PokemonListByTypeCubit(pokemonType, PokemonRepository()),
        child: Scaffold(
            appBar: AppBar(title: Text('${pokemonType.name.formatName()} pokémons!')),
            body: BlocBuilder<PokemonListByTypeCubit, PokedexViewState>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const PokedexLoading();
                }

                if (state is SuccessState<PokemonTypeDetails>) {
                  if (state.result.pokemons.isEmpty) {
                    return PokedexEmpty(pokemonTypeName: pokemonType.name);
                  } else {
                    return PokemonListWidget(state.result.pokemons, state.result.id);
                  }
                }

                if (state is ErrorState) {
                  return PokedexError(() => BlocProvider.of<PokemonListByTypeCubit>(context).getPokemonTypeDetails(pokemonType.id));
                }

                return PokedexEmpty(pokemonTypeName: pokemonType.name);
              },
            )));
  }
}

class PokemonListWidget extends StatelessWidget {
  final List<Pokemon> pokemonList;
  final int typeId;

  const PokemonListWidget(this.pokemonList, this.typeId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: pokemonList.length,
      itemBuilder: (context, position) {
        return PokemonListItemWidget(pokemonList[position], pokemonTypeEnumFrom(typeId).backgroundColor);
      },
    );
  }
}

class PokemonListItemWidget extends StatefulWidget {
  final Pokemon currentPokemon;
  final Color pokemonTypeBackgroundColor;

  const PokemonListItemWidget(this.currentPokemon, this.pokemonTypeBackgroundColor, {Key? key}) : super(key: key);

  @override
  State<PokemonListItemWidget> createState() => _PokemonListItemWidgetState();
}

class _PokemonListItemWidgetState extends State<PokemonListItemWidget> {
  bool isOpened = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PokemonDetailCubit(widget.currentPokemon.id, PokemonRepository()),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isOpened = !isOpened;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
          child: Card(
            color: widget.pokemonTypeBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: BlocBuilder<PokemonDetailCubit, PokedexViewState>(
                builder: (context, state) {
                  if (state is SuccessState<PokemonDetails>) {
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
                              Column(
                                children: [
                                  ...state.result.types.map((type) {
                                    return PokemonTypeCard(type.id);
                                  })
                                ],
                              ),
                              Image.network(state.result.sprite, height: 75),
                            ],
                          ),
                          if (isOpened)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Text('Height', style: TextStyle(color: Colors.white)),
                                    Text(state.result.height.formatHeight(), style: const TextStyle(color: Colors.white)),
                                    const SizedBox(height: 20),
                                    const Text('Weight', style: TextStyle(color: Colors.white)),
                                    Text(state.result.weight.formatWeight(), style: const TextStyle(color: Colors.white)),
                                  ],
                                ),
                                Column(
                                  children: [
                                    const Text('Base Stats', style: TextStyle(color: Colors.white)),
                                    const SizedBox(height: 10),
                                    ...state.result.stats.map((stat) {
                                      return Text('${stat.name}: ${stat.baseStat.toString()}', style: const TextStyle(color: Colors.white));
                                    })
                                  ],
                                )
                              ],
                            )
                        ],
                      ),
                    );
                  }

                  return PokedexError(() {});
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
