class PokemonType {
  final String name;
  final int id;

  PokemonType(this.name, this.id);

  @override
  String toString() => "{name: $name, id: $id}";

  factory PokemonType.fromJson(Map<String, dynamic> json) {
    try {
      final pokemonTypeResponse = json['results'];
      final url = pokemonTypeResponse['url'].toString();
      final id = int.parse(url.substring(url.indexOf("type/") + 5, url.length - 1));
      return PokemonType(pokemonTypeResponse['name'].toString(), id);
    } catch (ex) {
      throw Exception(ex);
    }
  }
}