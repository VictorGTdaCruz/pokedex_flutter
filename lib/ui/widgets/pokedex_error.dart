import 'package:flutter/material.dart';

class PokedexError extends StatelessWidget {
  const PokedexError(this.onRetry, {Key? key}) : super(key: key);

  final Function onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/img_pikachu_sad.png',
              height: 175
            ),
            const SizedBox(height: 15),
            const Text(
              'Looks like something wrong happened!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              child: const Text('Reload'),
              onPressed: () => onRetry.call()),
          ],
        ),
      ),
    );
  }
}