import 'package:flutter/material.dart';

class PokedexError extends StatelessWidget {
  const PokedexError(this.onRetry, {Key? key}) : super(key: key);

  final Function onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: const Text('Error'),
        onPressed: () => onRetry.call()),
    );
  }
}