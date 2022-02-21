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
        return PokedexColors.Normal;
      case PokemonTypeEnum.fighting:
        return PokedexColors.Fighting;
      case PokemonTypeEnum.flying:
        return PokedexColors.Flying;
      case PokemonTypeEnum.poison:
        return PokedexColors.Poison;
      case PokemonTypeEnum.ground:
        return PokedexColors.Ground;
      case PokemonTypeEnum.rock:
        return PokedexColors.Rock;
      case PokemonTypeEnum.bug:
        return PokedexColors.Bug;
      case PokemonTypeEnum.ghost:
        return PokedexColors.Ghost;
      case PokemonTypeEnum.steel:
        return PokedexColors.Steel;
      case PokemonTypeEnum.fire:
        return PokedexColors.Fire;
      case PokemonTypeEnum.water:
        return PokedexColors.Water;
      case PokemonTypeEnum.grass:
        return PokedexColors.Grass;
      case PokemonTypeEnum.electric:
        return PokedexColors.Electric;
      case PokemonTypeEnum.psychic:
        return PokedexColors.Psychic;
      case PokemonTypeEnum.ice:
        return PokedexColors.Ice;
      case PokemonTypeEnum.dragon:
        return PokedexColors.Dragon;
      case PokemonTypeEnum.dark:
        return PokedexColors.Dark;
      case PokemonTypeEnum.fairy:
        return PokedexColors.Fairy;
      case PokemonTypeEnum.shadow:
      case PokemonTypeEnum.unknown:
        return PokedexColors.Unknown;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case PokemonTypeEnum.normal:
        return PokedexColors.NormalBackground;
      case PokemonTypeEnum.fighting:
        return PokedexColors.FightingBackground;
      case PokemonTypeEnum.flying:
        return PokedexColors.FlyingBackground;
      case PokemonTypeEnum.poison:
        return PokedexColors.PoisonBackground;
      case PokemonTypeEnum.ground:
        return PokedexColors.GroundBackground;
      case PokemonTypeEnum.rock:
        return PokedexColors.RockBackground;
      case PokemonTypeEnum.bug:
        return PokedexColors.BugBackground;
      case PokemonTypeEnum.ghost:
        return PokedexColors.GhostBackground;
      case PokemonTypeEnum.steel:
        return PokedexColors.SteelBackground;
      case PokemonTypeEnum.fire:
        return PokedexColors.FireBackground;
      case PokemonTypeEnum.water:
        return PokedexColors.WaterBackground;
      case PokemonTypeEnum.grass:
        return PokedexColors.GrassBackground;
      case PokemonTypeEnum.electric:
        return PokedexColors.ElectricBackground;
      case PokemonTypeEnum.psychic:
        return PokedexColors.PsychicBackground;
      case PokemonTypeEnum.ice:
        return PokedexColors.IceBackground;
      case PokemonTypeEnum.dragon:
        return PokedexColors.DragonBackground;
      case PokemonTypeEnum.dark:
        return PokedexColors.DarkBackground;
      case PokemonTypeEnum.fairy:
        return PokedexColors.FairyBackground;
      case PokemonTypeEnum.shadow:
      case PokemonTypeEnum.unknown:
        return PokedexColors.Unknown;
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