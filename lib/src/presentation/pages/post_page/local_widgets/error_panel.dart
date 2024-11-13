import 'package:flutter/material.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';

class ErrorPanel extends StatelessWidget {
  const ErrorPanel({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).colorScheme.onPrimaryContainer;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(
          Icons.question_mark_rounded,
          size: 100,
          color: color,
        ),
        const SizedBox(height: 8),
        Text(
          Messages.of(context).errorPost,
          style: TextStyle(color: color),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
