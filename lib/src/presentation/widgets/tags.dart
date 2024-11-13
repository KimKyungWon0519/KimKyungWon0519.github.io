import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  final List<String> tags;

  const Tags({
    super.key,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: tags
          .map((tag) => Text(
                tag,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ))
          .toList(),
    );
  }
}
