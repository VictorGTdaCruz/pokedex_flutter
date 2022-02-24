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
      create: (context) => PokemonTypeCubit(PokemonTypeRepository())..getPokemonTypes(),
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
                  ...state.result.expand((type) => [
                    Container(
                        margin: const EdgeInsets.all(4),
                        child: PokemonTypeCard(
                          type.id,
                          onPressed: () {
                            final pokemonType = PokemonType(
                                type.id, pokemonTypeEnumFrom(type.id).name);
                            Provider
                                .of<PokemonTypeCache>(context, listen: false)
                                .pokemonType = pokemonType;
                            Navigator.push(context, MaterialPageRoute(
                                builder: (_) =>
                                const PokemonTypeDetailsPage(title: ''))
                            );
                          }
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