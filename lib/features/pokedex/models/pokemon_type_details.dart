class PokemonTypeDetails {
  PokemonTypeDetails(this.id, this.name, this.pokemons);

  final int id;
  final String name;
  final List<Pokemon> pokemons;

  @override
  String toString() => '{name: $name, id: $id}';

  factory PokemonTypeDetails.fromJson(Map<String, dynamic> json) {
    try {
      print(json);
      final test = json['pokemon'];
      final pokemons = test.map<Pokemon>((element) {
        print(element);
        return Pokemon.fromJson(element);
      }).toList();
      return PokemonTypeDetails(json['id'], json['name'], pokemons);
    } catch (ex) {
      print(ex);
      throw Exception(ex);
    }
  }
}

class Pokemon {
  Pokemon(this.id, this.name);

  final int id;
  final String name;

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    try {
      print(json);
      final pokemon = json['pokemon'];
      final url = pokemon['url'];
      final id = int.parse(url.substring(url.indexOf('pokemon/') + 8, url.length - 1));
      return Pokemon(id, pokemon['name']);
    } on Exception catch (exception) {
      print(exception);
      rethrow;
    }
  }
}