import 'package:flutter/material.dart';

class Title extends StatelessWidget {
  final String text;

  const Title(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headlineLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
