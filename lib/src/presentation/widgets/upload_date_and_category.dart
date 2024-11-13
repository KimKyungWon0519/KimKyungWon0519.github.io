import 'package:flutter/material.dart';

class UploadDateAndCategory extends StatelessWidget {
  final String createAt;
  final String category;

  const UploadDateAndCategory({
    super.key,
    required this.createAt,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Text(createAt),
          const VerticalDivider(),
          Text(
            category,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
