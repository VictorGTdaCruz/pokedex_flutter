import 'package:flutter/material.dart';

class PokedexEmpty extends StatelessWidget {
  const PokedexEmpty({ this.pokemonTypeName, Key? key }): super (key: key);

  final String? pokemonTypeName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/img_pikachu_resting.png',
            height: 175,
          ),
          const SizedBox(height: 15),
          if (pokemonTypeName != null)
            Text(
              'Looks like we haven\'t discovered any pokémon of the type $pokemonTypeName yet.',
              textAlign: TextAlign.center,
            )
          else
            const Text(
              'Looks like there is nothing in here.',
              textAlign: TextAlign.center,
            )
          ]
      ),
    );
  }
}