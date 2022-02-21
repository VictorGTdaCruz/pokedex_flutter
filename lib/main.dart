import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex_flutter/features/pokedex/pokemon_type_enum.dart';
import 'package:pokedex_flutter/features/pokedex/repositories/pokedex_repository.dart';
import 'package:provider/provider.dart';

import 'features/pokedex/bloc/pokedex_cubit.dart';

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
    return Provider<PokedexCubit>(
        create: (context) => PokedexCubit(PokedexRepository()),
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: BlocBuilder<PokedexCubit, PokemonTypeState>(
            builder: (context, state) {
              if (state is LoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is ErrorState) {
                return Center(
                  child: TextButton(
                    child: const Text('Error'),
                    onPressed: () =>
                        BlocProvider.of<PokedexCubit>(context).getPokemonTypes(),
                  ),
                );
              }

              if (state is SuccessState) {
                return GridView.count(
                  shrinkWrap: true,
                  childAspectRatio: 3,
                  crossAxisCount: 2,
                  children: [
                    ...state.types.expand((element) => [
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

              return Center(
                child: TextButton(
                  child: const Text('Empty'),
                  onPressed: () =>
                      BlocProvider.of<PokedexCubit>(context).getPokemonTypes(),
                ),
              );
            },
          ),
        ),
    );
  }
}
