import 'package:flutter/material.dart';
import 'package:kkw_blog/resource/l10n/generated/l10n.dart';

class ScrollUpFab extends StatelessWidget {
  final VoidCallback? onPressed;

  const ScrollUpFab({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: 'ScrollUpFab',
      onPressed: onPressed,
      label: Text(Messages.of(context).scrollUp),
      icon: const Icon(Icons.arrow_upward_rounded),
    );
  }
}
