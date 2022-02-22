import 'package:flutter/widgets.dart';

class PokemonsPage extends StatefulWidget {
  const PokemonsPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<PokemonsPage> createState() => PokemonsPageState();
}

class PokemonsPageState extends State<PokemonsPage> {

  @override
  Widget build(BuildContext context) {
    return const Text('Hello World!');
  }
}