import 'dart:ui';

import '../ui/design_system/pokedex_colors.dart';

enum PokemonTypeEnum {
  normal,
  fighting,
  flying,
  poison,
  ground,
  rock,
  bug,
  ghost,
  steel,
  fire,
  water,
  grass,
  electric,
  psychic,
  ice,
  dragon,
  dark,
  fairy,
  shadow,
  unknown
}

PokemonTypeEnum pokemonTypeEnumFrom(int id) {
  switch (id) {
    case 10002:
      return PokemonTypeEnum.shadow;
    case 10001:
      return PokemonTypeEnum.unknown;
    default:
      for (var element in PokemonTypeEnum.values) {
        if (element.index + 1 == id) {
          return element;
        }
      }
      return PokemonTypeEnum.unknown;
  }
}

extension PokemonTypeEnumExtension on PokemonTypeEnum {

  int get id {
    switch (this) {
      case PokemonTypeEnum.shadow:
        return 10002;
      case PokemonTypeEnum.unknown:
        return 10001;
      default:
        return index + 1;
    }
  }

  Color get color {
    switch (this) {
      case PokemonTypeEnum.normal:
        return PokedexColors.normal;
      case PokemonTypeEnum.fighting:
        return PokedexColors.fighting;
      case PokemonTypeEnum.flying:
        return PokedexColors.flying;
      case PokemonTypeEnum.poison:
        return PokedexColors.poison;
      case PokemonTypeEnum.ground:
        return PokedexColors.ground;
      case PokemonTypeEnum.rock:
        return PokedexColors.rock;
      case PokemonTypeEnum.bug:
        return PokedexColors.bug;
      case PokemonTypeEnum.ghost:
        return PokedexColors.ghost;
      case PokemonTypeEnum.steel:
        return PokedexColors.steel;
      case PokemonTypeEnum.fire:
        return PokedexColors.fire;
      case PokemonTypeEnum.water:
        return PokedexColors.water;
      case PokemonTypeEnum.grass:
        return PokedexColors.grass;
      case PokemonTypeEnum.electric:
        return PokedexColors.electric;
      case PokemonTypeEnum.psychic:
        return PokedexColors.psychic;
      case PokemonTypeEnum.ice:
        return PokedexColors.ice;
      case PokemonTypeEnum.dragon:
        return PokedexColors.dragon;
      case PokemonTypeEnum.dark:
        return PokedexColors.dark;
      case PokemonTypeEnum.fairy:
        return PokedexColors.fairy;
      case PokemonTypeEnum.shadow:
      case PokemonTypeEnum.unknown:
        return PokedexColors.unknown;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case PokemonTypeEnum.normal:
        return PokedexColors.normalBackground;
      case PokemonTypeEnum.fighting:
        return PokedexColors.fightingBackground;
      case PokemonTypeEnum.flying:
        return PokedexColors.flyingBackground;
      case PokemonTypeEnum.poison:
        return PokedexColors.poisonBackground;
      case PokemonTypeEnum.ground:
        return PokedexColors.groundBackground;
      case PokemonTypeEnum.rock:
        return PokedexColors.rockBackground;
      case PokemonTypeEnum.bug:
        return PokedexColors.bugBackground;
      case PokemonTypeEnum.ghost:
        return PokedexColors.ghostBackground;
      case PokemonTypeEnum.steel:
        return PokedexColors.steelBackground;
      case PokemonTypeEnum.fire:
        return PokedexColors.fireBackground;
      case PokemonTypeEnum.water:
        return PokedexColors.waterBackground;
      case PokemonTypeEnum.grass:
        return PokedexColors.grassBackground;
      case PokemonTypeEnum.electric:
        return PokedexColors.electricBackground;
      case PokemonTypeEnum.psychic:
        return PokedexColors.psychicBackground;
      case PokemonTypeEnum.ice:
        return PokedexColors.iceBackground;
      case PokemonTypeEnum.dragon:
        return PokedexColors.dragonBackground;
      case PokemonTypeEnum.dark:
        return PokedexColors.darkBackground;
      case PokemonTypeEnum.fairy:
        return PokedexColors.fairyBackground;
      case PokemonTypeEnum.shadow:
      case PokemonTypeEnum.unknown:
        return PokedexColors.unknown;
    }
  }

  String get icon {
    switch (this) {
      case PokemonTypeEnum.normal:
        return 'assets/images/normal.svg';
      case PokemonTypeEnum.fighting:
        return 'assets/images/fighting.svg';
      case PokemonTypeEnum.flying:
        return 'assets/images/flying.svg';
      case PokemonTypeEnum.poison:
        return 'assets/images/poison.svg';
      case PokemonTypeEnum.ground:
        return 'assets/images/ground.svg';
      case PokemonTypeEnum.rock:
        return 'assets/images/rock.svg';
      case PokemonTypeEnum.bug:
        return 'assets/images/bug.svg';
      case PokemonTypeEnum.ghost:
        return 'assets/images/ghost.svg';
      case PokemonTypeEnum.steel:
        return 'assets/images/steel.svg';
      case PokemonTypeEnum.fire:
        return 'assets/images/fire.svg';
      case PokemonTypeEnum.water:
        return 'assets/images/water.svg';
      case PokemonTypeEnum.grass:
        return 'assets/images/grass.svg';
      case PokemonTypeEnum.electric:
        return 'assets/images/electric.svg';
      case PokemonTypeEnum.psychic:
        return 'assets/images/psychic.svg';
      case PokemonTypeEnum.ice:
        return 'assets/images/ice.svg';
      case PokemonTypeEnum.dragon:
        return 'assets/images/dragon.svg';
      case PokemonTypeEnum.dark:
        return 'assets/images/dark.svg';
      case PokemonTypeEnum.fairy:
        return 'assets/images/fairy.svg';
      case PokemonTypeEnum.shadow:
      case PokemonTypeEnum.unknown:
        return 'assets/images/pokeball.svg';
    }
  }
}