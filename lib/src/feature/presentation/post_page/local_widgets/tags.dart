import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  final List<String> tags;

  const Tags(this.tags, {super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: tags
          .map(
            (e) => Text('#$e'),
          )
          .toList(),
    );
  }
}
