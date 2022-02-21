class PokemonType {
  final String name;
  final int id;

  PokemonType(this.name, this.id);

  @override
  String toString() => '{name: $name, id: $id}';

  static List<PokemonType> fromJson(Map<String, dynamic> json) {
    try {
      final pokemonTypeResponse = json['results'];
      return pokemonTypeResponse.map<PokemonType>((element) {
          final url = element['url'].toString();
          final id = int.parse(url.substring(url.indexOf('type/') + 5, url.length - 1));
          return PokemonType(element['name'].toString(), id);
      }).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }
}