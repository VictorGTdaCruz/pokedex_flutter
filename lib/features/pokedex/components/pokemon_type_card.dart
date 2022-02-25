import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex_flutter/features/pokedex/utils/pokedex_formatter.dart';

import '../pokemon_type_enum.dart';

class PokemonTypeCard extends StatelessWidget {
  const PokemonTypeCard(this.pokemonTypeId, {this.fontSize = 14, this.onPressed, this.imageSize = 15, Key? key}): super(key: key);

  final int pokemonTypeId;
  final int fontSize;
  final int imageSize;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith(
              (states) => pokemonTypeEnumFrom(pokemonTypeId).color
      )),
      // style: ElevatedButton.styleFrom(primary: pokemonTypeEnumFrom(pokemonTypeId).backgroundColor),
      onPressed: () => onPressed?.call(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            pokemonTypeEnumFrom(pokemonTypeId).icon,
            width: imageSize.toDouble(),
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            pokemonTypeEnumFrom(pokemonTypeId).name.formatName(),
            style: TextStyle(fontSize: fontSize.toDouble()),
          ),
        ],
      )
    );
  }
}