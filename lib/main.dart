import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex_flutter/arch/podekex_cubit.dart';
import 'package:pokedex_flutter/features/pokedex/bloc/pokemon_type_cubit.dart';
import 'package:pokedex_flutter/features/pokedex/pokemon_type_enum.dart';
import 'package:pokedex_flutter/features/pokedex/repositories/pokemon_type_repository.dart';
import 'package:pokedex_flutter/features/ui/widgets/pokedex_empty.dart';
import 'package:pokedex_flutter/features/ui/widgets/pokedex_error.dart';
import 'package:pokedex_flutter/features/ui/widgets/pokedex_loading.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
                            onPressed: () => print(element.name),
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
