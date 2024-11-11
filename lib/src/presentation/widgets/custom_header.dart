import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kToolbarHeight,
      child: DefaultTextStyle(
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          fontSize: 12,
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('(C) 2024. KimKyungWon All rights reserved.'),
            Text('v1.0.0'),
          ],
        ),
      ),
    );
  }
}
