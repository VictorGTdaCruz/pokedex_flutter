class PokemonDetails {
  PokemonDetails(this.id, this.name, this.height, this.weight, this.types, this.stats, this.sprite);

  final int id;
  final String name;
  final int height;
  final int weight;
  final List<PokemonTypeWithSlot> types;
  final List<PokemonStat> stats;
  final String sprite;

  @override
  String toString() => '{id: $id, name: $name, types: $types}';

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    try {
      final types = json['types'].map<PokemonTypeWithSlot>((type) {
        final url = type['type']['url'];
        final id = int.parse(
            url.substring(url.indexOf('type/') + 5, url.length - 1));
        return PokemonTypeWithSlot(type['slot'], id, type['type']['name']);
      }).toList();
      final stats = json['stats'].map<PokemonStat>((stat) => PokemonStat(stat['stat']['name'], stat['base_stat'])).toList();
      final sprite = json['sprites']['other']?['official-artwork']?['front_default'] ??
          json['sprites']['front_default'];
      return PokemonDetails(json['id'], json['name'], json['height'], json['weight'], types, stats, sprite);
    } catch (ex) {
      throw Exception(ex);
    }
  }
}

class PokemonTypeWithSlot {
  PokemonTypeWithSlot(this.slot, this.id, this.name);

  @override
  String toString() {
    return '{$id, $name}';
  }

  final int slot;
  final int id;
  final String name;
}

class PokemonStat {
  PokemonStat(this.name, this.baseStat);

  final String name;
  final int baseStat;
}