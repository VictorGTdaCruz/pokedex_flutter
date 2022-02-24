import 'package:flutter/material.dart';

class PokedexEmpty extends StatelessWidget {
  const PokedexEmpty(this.onRetry);

  final Function onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        child: const Text('Empty', style: TextStyle(fontSize: 50),),
        onPressed: () => onRetry.call(),
      )
    );
  }
}