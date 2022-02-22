import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pokedex_flutter/features/pokedex/models/pokemon_type.dart';
import 'package:provider/provider.dart';

import '../../pokemon_type_cache.dart';
import '../pages/pokemon_type_details_page.dart';
import '../pokemon_type_enum.dart';

class PokemonTypeCard extends StatelessWidget {
  const PokemonTypeCard(this.pokemonTypeId, {Key? key}): super(key: key);

  final int pokemonTypeId;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final pokemonType = PokemonType(pokemonTypeId, pokemonTypeEnumFrom(pokemonTypeId).name);
        Provider.of<PokemonTypeCache>(context, listen: false).pokemonType = pokemonType;
        Navigator.push(context, MaterialPageRoute(
            builder: (_) => const PokemonTypeDetailsPage(title: ''))
        );
      },
      style: ElevatedButton.styleFrom(primary: pokemonTypeEnumFrom(pokemonTypeId).backgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            pokemonTypeEnumFrom(pokemonTypeId).icon,
            width: 30,
            color: Colors.white,
          ),
          const SizedBox(width: 15),
          Text(pokemonTypeEnumFrom(pokemonTypeId).name),
        ],
      ),
    );
  }
}