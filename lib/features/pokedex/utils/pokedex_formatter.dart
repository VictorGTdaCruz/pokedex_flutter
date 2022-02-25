class PokedexFormatter {
  static int getIdFromTypeUrl(String typeUrl) {
    final id =
        typeUrl.substring(typeUrl.indexOf('type/') + 5, typeUrl.length - 1);
    return int.parse(id);
  }

  static int getIdFromPokemonUrl(String pokemonUrl) {
    final id = pokemonUrl.substring(
        pokemonUrl.indexOf('pokemon/') + 8, pokemonUrl.length - 1);
    return int.parse(id);
  }
}

extension IntExtension on int {
  String formatId() {
    switch (toString().length) {
      case 1:
        return '#00$this';
      case 2:
        return '#0$this';
      default:
        return '#$this';
    }
  }
}

extension StringExtension on String {
  String formatName() {
    return split('-')
        .map((word) => '${word[0].toUpperCase()}${word.substring(1)}')
        .join(' ');
  }
}
