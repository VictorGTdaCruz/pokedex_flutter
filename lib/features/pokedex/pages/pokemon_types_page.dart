import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex_flutter/features/pokedex/pages/pokemons_page.dart';
import 'package:provider/provider.dart';

import '../../../arch/podekex_cubit.dart';
import '../../ui/widgets/pokedex_empty.dart';
import '../../ui/widgets/pokedex_error.dart';
import '../../ui/widgets/pokedex_loading.dart';
import '../bloc/pokemon_type_cubit.dart';
import '../pokemon_type_enum.dart';
import '../repositories/pokemon_type_repository.dart';

class PokemonTypesPage extends StatefulWidget {
  const PokemonTypesPage(this.title, {Key? key}) : super (key: key);

  final String title;

  @override
  State<PokemonTypesPage> createState() => _PokemonTypesPageState();
}

class _PokemonTypesPageState extends State<PokemonTypesPage> {

  @override
  Widget build(BuildContext context) {
    return Provider<PokemonTypeCubit>(
      create: (context) => PokemonTypeCubit(PokemonTypeRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocBuilder<PokemonTypeCubit, PokedexState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return const PokedexLoading();
            }

            if (state is ErrorState) {
              return PokedexError(() => BlocProvider.of<PokemonTypeCubit>(context).getPokemonTypes());
            }

            if (state is SuccessState) {
              return GridView.count(
                childAspectRatio: 3,
                crossAxisCount: 2,
                children: [
                  ...state.result.expand((element) => [
                    Container(
                        margin: const EdgeInsets.all(4),
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PokemonsPage(title: ''))),
                          style: ElevatedButton.styleFrom(primary: pokemonTypeEnumFrom(element.id).backgroundColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                pokemonTypeEnumFrom(element.id).icon,
                                width: 30,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 15),
                              Text(element.name),
                            ],
                          ),
                        )
                    )
                  ])
                ],
              );
            }

            return PokedexEmpty(() => BlocProvider.of<PokemonTypeCubit>(context).getPokemonTypes());
          },
        ),
      ),
    );
  }
}