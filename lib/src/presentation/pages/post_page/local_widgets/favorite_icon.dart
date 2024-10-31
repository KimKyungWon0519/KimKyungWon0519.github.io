import 'package:flutter/material.dart';

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
      onPressed: () {},
      icon: const Icon(Icons.favorite_border_rounded),
      label: Text('1'),
    );
  }
}
