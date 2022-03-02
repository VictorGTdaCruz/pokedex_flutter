import '../../../arch/api.dart';
import '../models/pokemon_type_details.dart';

class PokemonTypeDetailsRepository {
  PokemonTypeDetailsRepository();

  Future<PokemonTypeDetails> getPokemonTypeDetails(int id) async {
    final response = await api.dio.get('type/$id');
    final typeDetailsResponse = PokemonTypeDetails.fromJson(response.data);
    return typeDetailsResponse;
  }
}