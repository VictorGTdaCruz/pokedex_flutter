class PokemonType {
  final int id;
  final String name;

  PokemonType(this.id, this.name);

  @override
  String toString() => '{name: $id, id: $name}';

  static List<PokemonType> fromJson(Map<String, dynamic> json) {
    try {
      final pokemonTypeResponse = json['results'];
      return pokemonTypeResponse.map<PokemonType>((element) {
          final url = element['url'].toString();
          final id = int.parse(url.substring(url.indexOf('type/') + 5, url.length - 1));
          return PokemonType(id, element['name'].toString());
      }).toList();
    } catch (ex) {
      throw Exception(ex);
    }
  }
}