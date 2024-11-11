import 'package:flutter/material.dart';
import 'package:kkw_blog/src/core/constants/app_constants.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text('(C) 2024. KimKyungWon All rights reserved.'),
            Text('${packageInfo.version}'),
          ],
        ),
      ),
    );
  }
}
