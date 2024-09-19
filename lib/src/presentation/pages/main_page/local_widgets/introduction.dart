import 'package:flutter/material.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';

class Introduction extends StatelessWidget {
  const Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.inversePrimary,
      ),
      child: Text(
        Messages.of(context).introduction,
        textAlign: TextAlign.center,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
